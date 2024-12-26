plugins {
    kotlin("jvm") version "2.1.0"
    application
    `maven-publish`
}

group = "info.gianlucacosta.auroragithub"
version = "0.0.0"

application {
    mainClass.set("info.gianlucacosta.auroragithub.tests.AppKt")
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = application.mainClass.get()
    }
}

repositories {
    mavenCentral()

    maven {
        url = uri("https://repo.repsy.io/mvn/giancosta86/playground")
    }
}

dependencies {
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

publishing {
    publications {
        create<MavenPublication>("mavenKotlin") {
            from(components["kotlin"])
        }
    }

    repositories {
        maven {
            url = uri("https://repo.repsy.io/mvn/giancosta86/playground")
            credentials {
                username = System.getenv("JVM_AUTH_USER")
                password = System.getenv("JVM_AUTH_TOKEN")
            }
        }
    }
}

