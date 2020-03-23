Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154CA18FB23
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 18:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCWRQn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 13:16:43 -0400
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com ([40.107.94.91]:23264
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbgCWRQl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 13:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuXK62LNgmXjJxbSGiFYzPW/HMa3VMISRRAxfXMSlEdbegz03ENrexbTxtRhwyWSOevCwq0/bgYb3KO6W6NvZLtm7lVE0+y4GYr0LyzAnfaFFTSPOoFk5VWpzC797mImJ2g6eBnjSQ67p79gdDWJfvZlPvHQzlMevwT3JT4D3k5iVxN/urnAdOgrU7xre7K+XXkx/zoVfRsKlvnbwRUwpjUYpDUrF1gvlPehvF+5hbOoqdmCBmI0I8JoRa41Tx74txZbii8BH9GA9aTBTsCsvDaJjwsS4dAa1IEeLw8sEGHYCcszczq5G3ovJSuNbBcVgfQXDWra/wJNwLGZlqv61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34cffHmfyAcIIdjCAB30ex6Tp35VBh+wADNtaK4Umuc=;
 b=Vz3UQzJtKb+fIA8csYymgTo7d+FnVQiKgwU7bIPo8TeG0I68YofyaLEzeSIDa45ggolgl/8Bc72qKLbR76jwIvqEpV3a4y3RHewQ0H6rlm6Z3Y5qZY3sx7uOWxofg/Lj+zre2OPIkIsUlrVWwP8J1KOvKLWeQzHYCC86lKyQrOIbLp0otOFK7/+ak1ewSpaFtvgP6jc3sG2mft4k9mGE2N5zJeni9XBBkiix7z7qXNgThCJkt5tVKuWvC/SCoKbaVuzGjNtCfAvShetM0gZJz/cgJQIaZCyfyKFPTXP+MnMrQ4ZyJ+hZf9D8e2XzMZ/giHPqa37oHrVuv88dcKOM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34cffHmfyAcIIdjCAB30ex6Tp35VBh+wADNtaK4Umuc=;
 b=SbyJHSy6H6k3hf85SY91X1EX51cBiJ0Mc1ShfavZIythOh4M99ASQqCx+SQ50MmRrbG7ISQ19yxdiQqs7U0qTAIZ3KlojFAGzds7zp1tIOSHHzPFtcRM9lYFTT56i2I5z8eX+DUKHe8eosib0aAkDKDm9yrBkKP1IZErV6cN1KQ=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1035.namprd21.prod.outlook.com (2603:10b6:302:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Mon, 23 Mar
 2020 17:16:39 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 17:16:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V2 4/6] x86/Hyper-V: Report crash register data or ksmg
 before running crash kernel
Thread-Topic: [PATCH V2 4/6] x86/Hyper-V: Report crash register data or ksmg
 before running crash kernel
Thread-Index: AQHWARRUDuguXH5gg0uTXw2zl86LOqhWaytg
Date:   Mon, 23 Mar 2020 17:16:39 +0000
Message-ID: <MW2PR2101MB10526621D88B9D2327394F17D7F00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
 <20200323130924.2968-5-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200323130924.2968-5-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T17:16:36.9285206Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=15fcd8fa-183f-41f4-a441-cfcc7aa8627b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a4344f7-482b-4413-3d23-08d7cf4df340
x-ms-traffictypediagnostic: MW2PR2101MB1035:|MW2PR2101MB1035:|MW2PR2101MB1035:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1035B54033A1216074D291ACD7F00@MW2PR2101MB1035.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(7696005)(33656002)(81156014)(86362001)(81166006)(8676002)(8936002)(66556008)(52536014)(76116006)(66476007)(66946007)(186003)(64756008)(8990500004)(26005)(66446008)(71200400001)(6506007)(5660300002)(54906003)(55016002)(2906002)(10290500003)(316002)(110136005)(4326008)(478600001)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1035;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uU/oahSZuzkgrBDIL1LReRAIGIKwVZejN7JLjO2s7KreFG4angzaS6lPTeNM+vZBInO72MLFdWMCuOi+gmuew6EkLWtTJB1DyNgNwNV9CfX/F7o9XW3iulaRJa0HbpBCtn1b9pX28+hL0oG6OI7kcgrlWMw2LJsWbTskrJ7+AVbeSMa72LvMR3ByUR7LaTWcACzMbdfTfAq7Q8cCHdXOETcg0FHkfB/Lfx03xZspBqOA03Ty7n/9P9A5M9hqxElMO0g/r6Ro1gagaNCKNYhKphw8zoZJ20zvpBsoWuut9oSx0LRyN42GU8wTAaBoVA2ZSaB7wUsQsu813TgOajMBt0YN/1i2pNUGu10tfDoGXUjnLRO3R+22YnKu1ShYK0vbhLfWUwnxtZoLRL9Gn11mwALObcpKyVXD+kUwYIvlbv9F3k2oSvZs2tThEgsgfqk0nvw7BoCAaj2fD1cM6aIc3bMk91TmQSFl3mPMabn48DGBKRJdIrWBXz1YPXmkc5hx
x-ms-exchange-antispam-messagedata: 93nbieScnf77GXxKgNp5oZm2/8wFjUyoA1ahvOMabMpHDwqPTlp0Sji4Tah6tJJFiWcA5M4egc/yWLFDbeh5CMW2Si8alNYyVZvWR7eStDDtrSQPkvWSVGaSqLQ8Qmbghru0BRfYAn59qij/sU6TJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4344f7-482b-4413-3d23-08d7cf4df340
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:16:39.2291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JET/e19fVLCtbK6x7lr7jZ6TtRsT9AjzCbVDzdyinsYCCnqHtBpRYKv5UxPDAU+HX0KoAXLKkxwfzn+qy3IGD3803LdT6hO+GZZa9weQZc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1035
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Monday, March 23, 2020 6:=
09 AM
>=20
> When a guest VM panics, Hyper-V should be notified only once via the
> crash synthetic MSRs.  Current Linux code might write these crash MSRs
> twice during a system panic:
> 1) hyperv_panic/die_event() calling hyperv_report_panic()
> 2) hv_kmsg_dump() calling hyperv_report_panic_msg()
>=20
> Fix this by not calling hyperv_report_panic() if a kmsg dump has been
> successfully registered.  The notification will happen later via
> hyperv_report_panic_msg().

I think this patch got the wrong commit message.  This message is the same
as in patch 3 of the series.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>        Update commit log
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index caa032ce3fe3..5e296a7e6036 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -263,6 +263,16 @@ static void __init ms_hyperv_init_platform(void)
>  			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
>  	}
>=20
> +	/*
> +	 * Hyper-V expects to get crash register data or kmsg when
> +	 * crash enlightment is available and system crashes. Set
> +	 * crash_kexec_post_notifiers to be true to make sure that
> +	 * calling crash enlightment interface before running kdump
> +	 * kernel.
> +	 */
> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> +		crash_kexec_post_notifiers =3D true;
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
>  	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
> --
> 2.14.5

