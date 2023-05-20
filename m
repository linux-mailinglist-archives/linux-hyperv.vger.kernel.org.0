Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0170A941
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 May 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjETQjo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 20 May 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETQjm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 20 May 2023 12:39:42 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6A124;
        Sat, 20 May 2023 09:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N99OJ+kI9ksX9izyXBqCvP0C/SjbiHZlgDuCmOxDGhdd9/9BaeVboSy8xZo30WHIZN1kUsQ6AkVjVRbvn6W1ew/DriVD2uYD7r1QrfNPUZtc4YM1gnVlYgm6KDwx1EFpiismdmD65RvKB+sYwaA0D9ubH2sjd3jogEG+kKmbI2/RPN3WMV/+gW9ZyLZFMHBGd5prN5U55R/9wVSybVTYGlbkbKupjP4OR8XObcu+wDsyRx8klx7QEjhw/lgQCIjugS0cCfP46wpbxX+8qVcTdP3XYgpuzWqwZWZMCgShfQD37DJF4JFtHXpSanlVOyWRUBd74fl8wNb6fL66E2GxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR9X2wT0f3qH/ZgRrFwUAolEDxuuRQYnG86etsudRb0=;
 b=QiCs1O+VwtoQMQObPaJpbUJQ39V6FywnZ0X4JNCrioTP9KaOd8YhvRKGegpGjClbcW14TA/3fEDF4xMI6bjmlwtqfUB3piSsxrAXqZHQApAXgyWYBktOOCxGiACEtR1XlRBDRA4pjyrhjyjuI3eNnEXmY6LtKJKp6tHo/26+FyHkCeTFjoF5J8PrSXNPGvMAzjMG9Vk5qOISf61kjkCyXTgHZhAfj1o03smEjKEy1KjtgCmTM6MlRjvFHrIOSkv5W1Z/RHli3Fa7FvCWJ8KpVEJFAsEo5fAsZxS9NhI4gYG6MMybDoFiPL75udu/1H+khqKIpdNqA2U94UMfHgYGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR9X2wT0f3qH/ZgRrFwUAolEDxuuRQYnG86etsudRb0=;
 b=aQ2e+i5rBqstsHo02i3+w1fLAkgTZUJSKLXwZypS+NP7Rvl2qMbd3Ulxv7ajT8T+LsPfPvjK0vC9PatX7UdgG9e7F9vta6AMRrCSzVCYtrUkcY5mz2/F0lMAisyB31LlRDRbznLINsClOT1nZjbQPgQFzxd8dehudtBUpaHjdtY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6; Sat, 20 May
 2023 16:39:38 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31%5]) with mapi id 15.20.6433.010; Sat, 20 May 2023
 16:39:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE disable for OF
 platforms
Thread-Topic: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE disable for OF
 platforms
Thread-Index: AQHZhBiTQDHZhYHO+EarWgaEDyjfiK9jauow
Date:   Sat, 20 May 2023 16:39:36 +0000
Message-ID: <BYAPR21MB16882F952165425972AE51CFD77DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=539fa200-48bf-49ea-9c2a-4ab57600cd5d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-20T16:38:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3457:EE_
x-ms-office365-filtering-correlation-id: 0b605ed7-2c55-43bc-a3fa-08db5950cc6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6zdCjhhu7xjrJ6MPY96q8foZFRat4Tkr1SRqfAMlq0zPkcXM/RHf1TIN9NBXxr2kn8zoUutliP2ymtoR96TBtMTQOZJboB0Q35InZXnwoWR715qmkAXrMT8EpQSzQgsViMsh7UjVgHxja3zvvozkqD7nH5ne69D3/khKeLU15C7Z/caE5uWatPb243KPoYpSIzs54nFF7vH3f5spiFMk5UKWgg1ffW0raZeXX2lbSsU4twmosyfjiogfxWWhluQ+2Zs3KU1L8Pp6N6OhFhbm8IhVfr7FuUH7zna9+A7POO4Ily8COsUxpdkvMYSjNfMKS+8aBG/GaAPEGHLftVzR+lsKyRQLaU/96vZ6Dpf55eSTGGeXfvF3534He4JJL86FOsDwKaOfVaX8MTZv0hImQmwjLKaLIXPJ3xkrlm8p//Nhjcxo+twpR1BzYiY8kow15O4mmuPfokLqdnB0ZqIi7qZ9KTnAO7TY9Yabo68uWc7qLuUra0PgObohZ1DgvamkJdGSS3TNjdI7rrIhBfxMHCTudkx8dcfyHWWd3ICc1vMohz6iZizLHF6yxfN5k+OG8Kog+KtVBAMYlWbf191P9GZ0dyyJVKY/9oI7YNHb7zgbTcQIue8JCKV7sWT7aDoAPhEw86kCj5iIZd0Ed8ApQqtV9oQ4bcbFqmM3WvbF1c06gvmg8jNraPB93iv77koM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(9686003)(76116006)(4744005)(64756008)(66556008)(66446008)(316002)(66476007)(2906002)(66946007)(33656002)(8676002)(8936002)(6506007)(186003)(5660300002)(86362001)(52536014)(107886003)(122000001)(83380400001)(26005)(38100700002)(38070700005)(82950400001)(82960400001)(8990500004)(55016003)(786003)(110136005)(10290500003)(41300700001)(71200400001)(4326008)(921005)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUGembDFMJmb5lU5o36RAiKCX1JO5k6DUU70d8fM+W8/kGkNio+U+WGa9hoq?=
 =?us-ascii?Q?CTu7xAQiAyMFjOZkrImDAi8b29PYbhBTE4HGQkP3CuG/InN20EZv6OglR1RT?=
 =?us-ascii?Q?msFMykcEe3qxsw+SAbiI3A5UZobhC20yV4fC57aNLa4Fa8FzCXxt1b/YANfF?=
 =?us-ascii?Q?DOjIssMb0Yzss4X9NaCrpqp57MtLEqPRIO/FQX/ovUFHf6sfs8gGKj2x8T3h?=
 =?us-ascii?Q?VcW7om49yhcr/L9/VV6ulBQyFaFXTQKPoVGRX2tQceeI+Tol3Wp9X7ONfq3/?=
 =?us-ascii?Q?Z+yTQ0wPDL2hceaNo3NfxCtb3iRpqpnqDY8uVRQuF7nvZ8mwD9DRjp/YXRVi?=
 =?us-ascii?Q?d2Uquq+FyKVD66NXhKYe4Pvibnn6NOnnn/jyC+uZVWpEFotSkIOqcGXlruT8?=
 =?us-ascii?Q?cS17JrggicrXejQnOidYiOmjqGwYAkcRhfHPH45ezvdj1OTrTtsdADTaVHsN?=
 =?us-ascii?Q?uRiTQhiVqYt+fMMbAuISnUBuDA3aSg+hvhRdui+kaKkMhZGIA+KgFRZM1p+1?=
 =?us-ascii?Q?98lT40dHwFN0q/xqu+nmrYTrCQoCk15moSfUTfQWUBmUomCFUX4zMN92Z5qn?=
 =?us-ascii?Q?GE/xo6w8C/jxGJ0SPuc3N10TqYkZ7gKjGOXt6SMUOE+MCOzOY9tH8Fu3Nvup?=
 =?us-ascii?Q?g+HlA0yqFS1QVKbmjR36oLkD6tvF1r2O7h+y/JLbp1QI8dXNbJEy1N0bzc13?=
 =?us-ascii?Q?yMocpXH5uijqTe5cR/XMuz+w4ofIih2DYTX7iAWduCIw+fyxv151sA0KlL7g?=
 =?us-ascii?Q?M0wjhzgqbX8IhNHRCuBBVtgiIkIw8ywGvsiSOiGWfDPoQo1k6JY/LFT7h/C/?=
 =?us-ascii?Q?ozTxcKixUeRg9xTH1I+zZx2bRQM98X0Tb68GjA5WDWKxoBxe7c2q9FX06ahQ?=
 =?us-ascii?Q?RQWGertyky9fcBeEtN6zfDkdwAYIO9tyn3kD9hqbXcctr6aiwp4hN3yQFUNg?=
 =?us-ascii?Q?DrTC29v4GMvz6/5c6tprTOpBkknbeTznY6BccYO93nkM/6qXJYgq8RnSJ3Yn?=
 =?us-ascii?Q?9W7xXlF0a9DgcTPKku1EmGqNtFhsh+vcX+mN55n+QPdg7dEjjEidLDeptsBL?=
 =?us-ascii?Q?S+Mj2vg7ZKaX0ay9mru2Oz1AF60yh92ys6IoDFvVEQJEijYd/wv8Tb8mfBeu?=
 =?us-ascii?Q?UKurcbHHgUl2vmHZgj7oIq6NhZtr8iRmhPS3Y7xvVA3LwVbtJlqOIittrkXu?=
 =?us-ascii?Q?umSzJkg0hhzOUdv+4wbUeeV5ZkCDslDbVYo6A2yrwcYtJF4oveIf7MtU6NwA?=
 =?us-ascii?Q?58K0BQ98EkAnEkUWsyy7fLB0WgtYSQEc0odEkicLmpQy8hbTF81rFFXJvIHb?=
 =?us-ascii?Q?6ZHEV5fu74uIUTzibHwF/2KWj5IMoW/l0xCVRDJCJON1vlYZwW7uFV9sZxfa?=
 =?us-ascii?Q?tc2iEI2z1fFae+ivZ1z27Qu//zehoDkfRFJOlXt4q7M1j6wMZ03f2mDoCxng?=
 =?us-ascii?Q?8qdBT98bicFAp3jFIeHLUqrIKZHR/vGD3/B8qIagx2NkSGvhu0gZy40EYzUN?=
 =?us-ascii?Q?8DiA6TOQ/2wIX55jTZChQjWVX7IwASGDCweWZ029EPiIPXE5BjAwuGdPH3c3?=
 =?us-ascii?Q?wQsUKPv5EBNeoRqk2rGohtniuuAZaszp47jMyP90NxYwX8sE9DHGxc/vYNZj?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b605ed7-2c55-43bc-a3fa-08db5950cc6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 16:39:36.4795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGWg/Qoq0nVNrDosgKY9IpmJBJ2yaRy61qYvHGJPjyOz/wsbdOix81YI/vpee/+1OGzfe2xcMRzfk5kK3qxq918aoP8hMxquZZ7oBqofcZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3457
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Thursday, May 11, =
2023 7:55 AM
>=20
> X86_MPPARSE is only selectable when ACPI is enabled. However,
> on Devicetree platforms where ACPI is disabled, it is always
> enabled. Allow X86_MPPARSE to be selected by OF platforms as
> well.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..e60315397399 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -469,7 +469,7 @@ config X86_X2APIC
>  	  If you don't know what to do here, say N.
>=20
>  config X86_MPPARSE
> -	bool "Enable MPS table" if ACPI
> +	bool "Enable MPS table" if ACPI || OF
>  	default y
>  	depends on X86_LOCAL_APIC
>  	help
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

