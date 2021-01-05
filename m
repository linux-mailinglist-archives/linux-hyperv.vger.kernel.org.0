Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE62EB268
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 19:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAESUy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 13:20:54 -0500
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:25505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbhAESUy (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 13:20:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU7hv9e/f0U1XJd0rW7jyW8mhAl/VrahRbFFHw1xHRwayztd5XdNGQG/MomctLsNI2IIsoae2Oy9FGbsGv9IW//ywGVAXGws6+rtcu2in7scrv3y4oPAzIZqyjscofCe0/kfALNmAEmeSR0vZQttBhKXN3m8dVC6uqrDWXjzPe1YayqGMeOgwtigcyWceefgXQSOaiC6m0C8yKVJTqtjtYd/0xgIr4fgS3FKkhy9fvyiJ6DD/hGqcixLXbSnMcmATwhApuPRdUZjxbc7rbD+d9V+YWsrkYRbfGeO0UAj0gzFMuQ8zZqKSS1WXRJDX9dZz6PCIzxHSShxW9LEBFPIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuQg8pcfok+Q3HbtB3yXPA862t8cUXioDEr7GzvER8k=;
 b=Z4CqHzx9BnEP/30dzTDTuJwaWJ4kVpiRQhSEZCIiNCxI2BGSNu3VWqeiY4zgcM8ZCn3JaLv1tmZQ1vua9kmltlJajJKliEvq4v+ifTFts1cvo6vr0TM1CCRKPvOnJMklOhGJMrsTV7XwJM5llBqPK6lAA4FJYnvh2TMsA+XrezQRQoXakCkb2p+cF+uOwniO0BIO3m36i9NrJicxyUV3pDeGQYCt9hhRf5vbFNOhd0uWYogQaASeNfGADyezFlIibrChy4c6nomHzu0mEFZDUFc/Mrqi87Y4LrbxWmiLESqwyXcM+7fmwh7aaL2fF4ZCyNQGnpXEac5yDyhih/RXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuQg8pcfok+Q3HbtB3yXPA862t8cUXioDEr7GzvER8k=;
 b=ci36QkjSmoShx2rDk9CqiFg8mHu2t6/Z1Y/Rh3ZpjRX0UFHBvjareGgWBiSFtVcvwSRJtcnEunJdk9ODcg2g4AbGq/ptDWlESMq1KWDp0rRoud0U2zDSZVzYalAXEmPCvE57DVqACXmFhPDVMVKulcCWkPnc4Vu9Oujw+/ziipY=
Received: from (2603:10b6:301:7c::11) by
 MWHPR21MB1547.namprd21.prod.outlook.com (2603:10b6:301:80::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Tue, 5 Jan 2021 18:20:05 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::1c55:439:e94c:be9e%5]) with mapi id 15.20.3763.002; Tue, 5 Jan 2021
 18:20:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "stable@kernel.org" <stable@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv: check cpu mask after interrupt has been
 disabled
Thread-Topic: [PATCH] x86/hyperv: check cpu mask after interrupt has been
 disabled
Thread-Index: AQHW44tO5NnOeOGnHk+aOh42E5R4cKoZV4Mw
Date:   Tue, 5 Jan 2021 18:20:05 +0000
Message-ID: <MWHPR21MB15935E00EAEFD70E49A22667D7D19@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210105175043.28325-1-wei.liu@kernel.org>
In-Reply-To: <20210105175043.28325-1-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-05T18:20:03Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4406508d-975c-4ac7-a0ad-fd750af6ca55;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 451d0f3c-8ece-42c5-f5b4-08d8b1a68688
x-ms-traffictypediagnostic: MWHPR21MB1547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB1547498BAE4C3F7526C490B6D7D19@MWHPR21MB1547.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1oIYgdyUFR3cgXOzuXaEnLvIA3S7K6MLbMTpgEm2erO/QsR8G674GAeloSPI4nnBK5kzb6hLBca7yFmeWyrN53oMn4NDkyF2EG1eoyH/PmvU2KYsz5zDTs8HAeeKoJUOo/BGoKRDfxxVNREZ/1k+hiwSFe5xaWdavRswyugQanUnE1v2LCYBIzq1rfrSZFfUtjH98lHgOFSg0kCx2iAjZO2X2vcG8DU19yX/tv5IL/EOUwtOjC1eY/0qcwif+7pymx2BTTKHw1gsNu8V68HeDUeWgWa2ere466XXQiSO/0sqm/zxl/95mwcE0wq4hazWxD+8ocoKjY6uT8q9IfdK4UUnUOptrjk5joeunwueeFVN/qg0uD0fWpA5n62eXbgbp7JLqBB+BJ67HbOOlvK4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(8990500004)(2906002)(52536014)(66446008)(66476007)(64756008)(6506007)(66556008)(10290500003)(33656002)(186003)(71200400001)(26005)(9686003)(55016002)(478600001)(8676002)(5660300002)(4326008)(76116006)(110136005)(66946007)(82950400001)(8936002)(82960400001)(54906003)(86362001)(7696005)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/pWf7h840jo+TGwrhw3tPnQrxVJ2qyMeOStZCjHioHr0KoHkPe9muLc11YBk?=
 =?us-ascii?Q?vHqqB/APC5qMjS/ySz4D2hYBNinlhaqAQbpASVfMNfYaFFlNT3IQy7r2MDhw?=
 =?us-ascii?Q?B4CBo+n8Obltb5Hq71n89ec3sW9nkFr0jqvb5LCXpVEB6aVTNqsrTr677nTA?=
 =?us-ascii?Q?OYnicXHwqtNFBSsc0biJexNI92g1RNosxIRVIwBrTorWVz4noEV4RJt8Wj8P?=
 =?us-ascii?Q?3Ij0ZuRv5kg6TXw78TBTDNcGOD/oSlVht1mgOZbsOs/r1VaFuS18YB0aSGYw?=
 =?us-ascii?Q?auCIs/kgB7A/lh6+k1O5VlU/16hi1B2u2Evwo1pRodUzNBTLzCm4VcEQv2Rg?=
 =?us-ascii?Q?1WqWY+ztcN5Fw7D/ZlavGmrBSTc5B41EdV4rs1PSpm4DUub1bCWk4DJ26nl8?=
 =?us-ascii?Q?6cIH8GGUfwwqfwKbYRNeRt7bPaXg7Se3Ez+eTfJrGNbRNWImx1KoNP0bdgJh?=
 =?us-ascii?Q?l2Hrc2VaAyYOVpZQ+UIWdt7DcJFgBP+rGf7ROlqw1uFhnkA/pMK9advCn8cM?=
 =?us-ascii?Q?f7FXYfLQmo6CPV/voUaIGwCtKfiO67qRoMmJbsHvphMOkoxLooI9vwFXu+xR?=
 =?us-ascii?Q?N4YTSZTE67w5sFATgWxrYomettsWMgecA5fPJPhjGo8H6ZWBj9787YSEPNvS?=
 =?us-ascii?Q?WdL/eZFwbOYSqGIB4zuKswQgg9DKsZy04Ws/Sjg/SL4weeJLx1YmA0UHOnCE?=
 =?us-ascii?Q?+SGZPgfkPv2i6KVPLsuGblq1HV7dJfTpVoivqF84agm5i9bpKhF3mjgIMi5B?=
 =?us-ascii?Q?lTUAmLNZTZwEVLfvwrFa3gR13p1T2JS1Z9vb2NIH9yhQ2JYMFpbo5fGKCXQe?=
 =?us-ascii?Q?p6nUYFGaphQM1sA2P/+EG12uX+t1YnVc5mM4DwdE3gcU0GaiXo+Y2bhWnewb?=
 =?us-ascii?Q?BtYNX22RgZ5uavjWixkjtbgivMLVyQzOQY6OZkC7f8bdDKvw4Jeg5ESJbMMi?=
 =?us-ascii?Q?0hlCQin5ayj0BZ9LqfmIPb4fG4G2v6iul7uit6qEzwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451d0f3c-8ece-42c5-f5b4-08d8b1a68688
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 18:20:05.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rK3ae7znTE1jcbtRmdiS06yIGUY5kwVr8v8Q4efeyc5yyGeiP3IcMrzt3DNmEf28yjWEbUjLuybWOeUD4O6ezLpDYTZqKz0k8vjAglGkqvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB1547
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, January 5, 2021 9:51 AM
>=20
> We've observed crashes due to an empty cpu mask in
> hyperv_flush_tlb_others.  Obviously the cpu mask in question is changed
> between the cpumask_empty call at the beginning of the function and when
> it is actually used later.
>=20
> One theory is that an interrupt comes in between and a code path ends up
> changing the mask. Move the check after interrupt has been disabled to
> see if it fixes the issue.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Cc: stable@kernel.org
> ---
>  arch/x86/hyperv/mmu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 5208ba49c89a..2c87350c1fb0 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -66,11 +66,17 @@ static void hyperv_flush_tlb_others(const struct cpum=
ask *cpus,
>  	if (!hv_hypercall_pg)
>  		goto do_native;
>=20
> -	if (cpumask_empty(cpus))
> -		return;
> -
>  	local_irq_save(flags);
>=20
> +	/*
> +	 * Only check the mask _after_ interrupt has been disabled to avoid the
> +	 * mask changing under our feet.
> +	 */
> +	if (cpumask_empty(cpus)) {
> +		local_irq_restore(flags);
> +		return;
> +	}
> +
>  	flush_pcpu =3D (struct hv_tlb_flush **)
>  		     this_cpu_ptr(hyperv_pcpu_input_arg);
>=20
> --
> 2.20.1

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

