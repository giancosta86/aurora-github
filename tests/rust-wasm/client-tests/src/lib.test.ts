import { describe, it, expect, beforeAll } from "vitest";
import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import initTestWasm, { add_ninety } from "@giancosta86/test-wasm";

describe("Test WebAssembly", () => {
  beforeAll(async () => {
    const wasmUrl = new URL(
      "../node_modules/@giancosta86/test-wasm/test_wasm_bg.wasm",
      import.meta.url
    );

    const wasmPath = fileURLToPath(wasmUrl);

    const buffer = await readFile(wasmPath);

    await initTestWasm(buffer);
  });

  it("should correctly add 90", () => {
    expect(add_ninety(5)).toBe(95);
  });
});
