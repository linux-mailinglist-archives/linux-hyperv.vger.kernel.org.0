Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237DE6182F6
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 16:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKCPe2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Nov 2022 11:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKCPe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Nov 2022 11:34:27 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021015.outbound.protection.outlook.com [52.101.52.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC0167ED;
        Thu,  3 Nov 2022 08:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOMgBDmBTBIjGKfXWJqfww+oFeR7jqC8NZJb0VzNQZMzSyVTMXynt30wBCuY5RIb4PiAzKu3Xy0BCaV4j9LPgTOQKNm/dhmary7sZa9X8fongTmqUC5AWw18Cuf27tM6x2BxmtFCPo0uy4FhnX1WDjQ4OK0Nmfsb8+TlvyNKeecKJg5a9kCYuYvHaSojRD41rVnW+coLFOHFPpb9iBiZIt30w1nfsCOtP99FrtBbIEwDnktlTMlu3yDL+CEC4782qZwGajVRi1CE07O5wcugPEmpEHLbJwB+T3wCxueb5t5TiV10lfosyCGzMgRPOgXG1/hm02DuJdznM6xLs4DDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl3Z7hjcwa9EyxzqUrPsrkQYXgaEn602lSW58TFoTgE=;
 b=GpaJu1EV1oXnDxsUKaYbefch0cMPHNz/2yFWNDA3jwM8JVQlD1PxQ01bBJkKyMLR8c/j9b8NzdS4/SEc38PetSyBCE+0eDn+uLjv3KL4TvNVlLI09h/trlGoIVIOxOSqpzrbcA0comxuT5pZdQe0KRhVXlEoN7GSaX1InflZDmy3H7IyjisSygavScesoV1Ei4TChruaU1mk+BBGN3KKL47ir5iU1HpdgkhWw9Isxfwp9PId4HuvcLY4bKZ/YY2dPsBYNNgD5nrDZNqHCg2xKMzReaH3SBP10+1Ft2LOPdaiHiW5Ma7WZBWoMRismi1ABwClmYgcSyP5Bi62Mm8AQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl3Z7hjcwa9EyxzqUrPsrkQYXgaEn602lSW58TFoTgE=;
 b=Ns/tXH5y/cyi3o0Abo5rtDOGnJSpJDL6E9kPmvQiTxEqPliBjT6ClhbHIY497kCizJbYRH7qbCA4Gagwm+vmq5r2UU2na5eNaJEd9bJmrME8TPpaHeFMQ4ouVOd3TP8p3e0KTt5Xal5CFP9dT4exWGpEBL9FJFJjwJtG8ySbNiA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN6PR2101MB1357.namprd21.prod.outlook.com (2603:10b6:805:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8; Thu, 3 Nov
 2022 15:34:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Thu, 3 Nov 2022
 15:34:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "mail@anirudhrb.com" <mail@anirudhrb.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Thread-Topic: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Thread-Index: AQHY75hVmfXQ8ic6FUK0rwzpn+K9rK4tU/gg
Date:   Thu, 3 Nov 2022 15:34:23 +0000
Message-ID: <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
In-Reply-To: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c058ec8-68fb-4624-9652-0e06497a74e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T15:33:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN6PR2101MB1357:EE_
x-ms-office365-filtering-correlation-id: d5b67337-999c-4d31-b2a3-08dabdb0e220
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUEN7fdP+aOQYvQvME7ZV3RV7JG4gRGnsOuqYdoL79mcaohl8/Bk3PsAdIYupAurFltlUzXmVvjXYJo4Em1Kgj4HOWgZHFbJdjYc0qWWkK8VPCiwg40gR5+4PJgC1DJxJjK1dSqZSe771+mgevYORM2MNkWVJFq6uZPEYkQnodLsjlSP5STYCyeWWuUB5XuwhG0l8razv34kOyQY0CAMyc0q9ZoitOnFr5HsxA8knytPmxufFVuS5McHug3ZlcTyfbzeXqhH8XeYJ4NR6bOTDybLrN5PKLNC/n6RDACI2GAbgN+rW+xxFx8qoRugNY3kFZshQhoUOmmRF45iPh04KwBQIJxvRACRPfLHQ2q2+HMyUdeH1dDmlxZD55+yTIQphhK+BcmGPywOfQGglkFnOAELRnwLCbrUchUsvp0UgjoJzdoHKwtKCRXq7V/qH8I4qBZjRgE9aDkDdb7ZbC8E7pvdSOqjAwiTj56PXWwA1eK+ueY0hKQJbT+/RXVF2SAijpz1DtLYY8TdV/rtpr16eCmF6shNuU2UUk/mTuN0dB5vGw1SwEDAzf1WvG98FelLgxPlin/p3onE3g8CLW4S5MNqadP3/L5d5rB+HL0p7XOlnGJiqtsMRyBOZP1WTS5ia2FSS0kU8Oo7D2jMMQRgTbXXBVUZHoUFGDiiPj0FGT6Gm5T+nebjkdG2YtY0pyBX+d04BOCxqLZ6lzE7/I90htPudLLHy3uXFppuRwKiDYkvr5nr8cau831SiG4mwYJTWcu2ccQAB4fD0Eu7uU4ASeej+1SaqUbfizBy0o4MpFa8M19/btsAd1bbhhSCV3Tv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(55016003)(71200400001)(82950400001)(82960400001)(5660300002)(2906002)(38100700002)(122000001)(86362001)(83380400001)(33656002)(38070700005)(186003)(9686003)(26005)(10290500003)(478600001)(54906003)(316002)(6506007)(110136005)(52536014)(66446008)(8936002)(64756008)(4326008)(66476007)(66946007)(66556008)(76116006)(8676002)(7696005)(41300700001)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dDftQdiMaZyolHAudAOHwZ/grOVDDbIVrwd/au8rOLy0Hg0uPZnqskgDTvsK?=
 =?us-ascii?Q?Tzv0YvkWBFC7M8yC4QqWj5CfSWanQowT57fQoWSgNf7gLMMV88WTVywDASV3?=
 =?us-ascii?Q?a2wxh69tJJ1dOVN0XzgF2CPjMrlPFQ+Ybwx7dyg5NrI7SZPBwt1Zzz2ovcFL?=
 =?us-ascii?Q?wWoNbENUKItVHlAigzOysJ0jRDMoLCjqlmyseuUTCRdaUGzSge0hft1e6Ajr?=
 =?us-ascii?Q?ms25IqV6BaMHc6vNRbzqLe+oSgaXbYtVghRAOXVoqtgiKktbij1ACwxhgpRm?=
 =?us-ascii?Q?bT/zmpukzQJI0kFZACrGWm0Kr8inZDuny7ahP39Twr77uY91u2J06JVkBNDR?=
 =?us-ascii?Q?Jx4IOt3iM1gDb32+X1XZCwGTtlxQr+H20LItlnJhIL5c5skc5v6WeOoOp8hu?=
 =?us-ascii?Q?q6DQLrguc4uYvkjsxRnkWRlUooxiWObQ8fQaT1ISbP65nnZEPb7qvYX/YFh0?=
 =?us-ascii?Q?4RNzvlmU0dQHpcXL5QiW49ztJ5QjAQQyVbcCwd7Gvby1DLmR2w9O98HYNmnx?=
 =?us-ascii?Q?5S875EJwOeUjOa5e/Fj1seFsE/2Shn2+ru1fWJaLjApSL1jPB1dIuqIMCink?=
 =?us-ascii?Q?ipZVXD65QjdcnNvPIZixoRrcZBKbtzjW414TbyI2H/Q2Dx83/oD9u/sWUx42?=
 =?us-ascii?Q?ZlqWJ+0giik1ex4Bp/Z/Xp80rsO4FxPo8tdXhAzBKYdXTzZab7dw+FbYfmh4?=
 =?us-ascii?Q?TzPFnaTD1Kny42SAHE9E5uAa5K+fwWxiwlW/N0/DRI6yo0nhg7WfvzH9JpiR?=
 =?us-ascii?Q?Qvp58LzwqGk6XGfAcgRt1uQT/HzSvSLzQefqgT/XJ6zLnA8pqV+Kc2VllW2K?=
 =?us-ascii?Q?dqAGzXKvHvfEvhQJJA7qQurHnwwADP5YovAUg2tmqBddFhleDIH03Mua8NGU?=
 =?us-ascii?Q?wzMS9zfxZU3XAAsZftHy4rV0maeRE/dWEe/qYMcfLmUAh3MVfy8G3qSOsLMV?=
 =?us-ascii?Q?cm8rE+e62B20gLv4yw0twkNKBqzcl3mMgr1UVUo4KanRVqEc79YtTQcZa1RO?=
 =?us-ascii?Q?+veRhxHFSrnPAkOtOkOss3yaD43LjQIjwq7RF4bRoaBOyjYRyokexF/BJsTf?=
 =?us-ascii?Q?0GQhff76c1sJZmITAmPmRo+hyWufufYr/xviy6ejwgEO7xqJmsPyrnBKumGG?=
 =?us-ascii?Q?Uh727tyzpO0vc64PQhemAKVs3cNRMgPK8y48hq1qcAbGUFt8xhejhSEagUlI?=
 =?us-ascii?Q?rQwcM52raLivRuIXBCLQeBqqpn7FDccmY/CrzEl4XHS1iVpojrxDIK8Ofrry?=
 =?us-ascii?Q?gL6LypIRQvHEWgmLx+Bq6a/fj78b/14u0ikQt/o8A9dEfMR0DhsldJD+NPD4?=
 =?us-ascii?Q?PFMDGOGLIu/qgXJ50gP93w0wrvJA1tCdUlN9TzAY8G2pCJvgPoA7BPczScOU?=
 =?us-ascii?Q?dkx4SdWS0aXGBZ5Z7EXhifWOpkTQKx0nY3i0wUctmm2cyoJZkIsKsVJfJV3c?=
 =?us-ascii?Q?xlDZa4MJIx208i7SK7g1JiLiOWgnsM5EQ2BNle3u2SWxhQM0qlle6kBNGw9W?=
 =?us-ascii?Q?Lgm0ZQ8l/zMaekksKImUYCHAF6bfwFxvWwEuS634SS5HmwkUAkmZQUE3jWgz?=
 =?us-ascii?Q?qge/qw2kWuRkXuPotaqDHTfgTGc/a+GKKytUBTR01VtueuV3mOCHMbhWDy5o?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b67337-999c-4d31-b2a3-08dabdb0e220
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 15:34:23.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRhreboc0Nk6xOupNl9QKg97lmG82+zz4Sd8Dy24JYMye+hhDqfyDZIPSLZfr4BGXokzzDb74U/81YEBV3/RT+tpV1zWitD3OyI04WTUMFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1357
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, Nov=
ember 3, 2022 8:24 AM
>=20
> __phys_to_pfn() will return a PFN based on the guest page size, which mig=
ht
> be different from Hyper-V's page size that is always 4K. The PFN for the
> TSC page always needs to be a Hyper-V PFN.
>=20
> Use HVPFN_DOWN() to calculate the PFN of the TSC page from the physical
> address.
>=20
> Reported-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index 11332c82d1af..18de1f439ffd 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/acpi.h>
> +#include <linux/hyperv.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
> @@ -412,7 +413,7 @@ static void resume_hv_clock_tsc(struct clocksource *a=
rg)
>  	/* Re-enable the TSC page */
>  	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr.enable =3D 1;
> -	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);
> +	tsc_msr.pfn =3D HVPFN_DOWN(phys_addr);
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
> @@ -532,7 +533,7 @@ static bool __init hv_init_tsc_clocksource(void)
>  	 */
>  	tsc_msr.as_uint64 =3D hv_get_register(HV_REGISTER_REFERENCE_TSC);
>  	tsc_msr.enable =3D 1;
> -	tsc_msr.pfn =3D __phys_to_pfn(phys_addr);
> +	tsc_msr.pfn =3D HVPFN_DOWN(phys_addr);
>  	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
>=20
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
