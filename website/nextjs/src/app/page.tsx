import Image from "next/image";
import logo from "../../public/next.svg";
import styles from "./page.module.css";

export default function Home() {
  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <Image
          className={styles.logo}
          src={logo}
          alt="Next.js logo"
          width={180}
          height={38}
          priority
        />

        <p>
          🤠<strong>Hi!</strong> 🐿️This is a static test page ensuring that{" "}
          <a href="https://github.com/giancosta86/aurora-github">
            aurora-github
          </a>{" "}
          can actually publish websites via GitHub Pages! 🤗🦋
        </p>
      </main>
    </div>
  );
}
