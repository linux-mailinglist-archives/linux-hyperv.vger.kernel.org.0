Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7518AA0E
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 01:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSAvz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Mar 2020 20:51:55 -0400
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com ([40.107.243.92]:24519
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbgCSAvz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Mar 2020 20:51:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4NisbRs7RZyejhsVYeojsU/bgOfACFQdLWEXct8xB0yXQTMzLr9Hk0v8x6ovCb0cxl7WhucaqCIp33yqB9Z8X9ilBXVoN7euRMo/jKcYAJy7JJYV5P6i6gLpcwQNWojhYWg7DR+ocSP4NkhykA6dRznUBdiMacmphQmw6I+NMs8wpI4f5gFfi17ehJ3rxquEa04xvTQXt+8CBb2v7U+z2gKFB7uBE58ynNDHJfi1oxAvVsrm5sZa4G8JOdlm5LnuLNVEv5MoZO7zfnQEcz1a0LE9QQHVBw1I39KAbIizSZJ8gFdKPvrL1nzOEZodHAGx6b/6cjnzCqViWGO40bARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6e/FVZmktBGIvdXU8PJ7EskBxrdAuBr6MeQCPHnk7A=;
 b=i2g5uIwcHy44jvaWA34kCUrpkX5TgO6TD5cAxc9Wm/vLXsAJJTMQ8tUccgcCWNpFbi0gmkWRdMuMxs/mIXmmEXRYXsJ/rsXuUIl/9vxh5pl6dWZCTKKhdomfksCq21OaM8LFqOWwuEX9o2/4Bqv1X9EnpiOuBC/O40t03w6snbb5GbBPMikNbl2YGwwzLbMm7PVAWPh9vyP7VTN075gInoLNQjtCCjRoUUo5fw3djAxIcgpt3j3P8T2pcHE/Yt4X0a4LMWhkvxzeER2uMaVgpfPRoxPr/Qu3T4+qmjDNE/KU/unrob++pQH0kD8Gt6VHxzhmRrFugzPqE4klLDeVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6e/FVZmktBGIvdXU8PJ7EskBxrdAuBr6MeQCPHnk7A=;
 b=Q5h4OZtWc2TCqkamhaehGUZG87Uwo3jP6cWcLc/mjflLKnNsGhSUyPRevOTaKE0DBMXC8sHxhO+vzHOBHbXWAs6RzBatr4wQ3I7OQ0obcrX3w7J11o5EYI2Ui2q+/pUwtTa46lBozPABYPxfbd+jktGU4BAD0BBa+FF1a15hc9E=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0924.namprd21.prod.outlook.com (2603:10b6:302:10::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.3; Thu, 19 Mar
 2020 00:51:15 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2835.003; Thu, 19 Mar 2020
 00:51:15 +0000
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
Subject: RE: [PATCH 4/4] x86/Hyper-V: Report crash register data or ksmg
 before  running crash kernel
Thread-Topic: [PATCH 4/4] x86/Hyper-V: Report crash register data or ksmg
 before  running crash kernel
Thread-Index: AQHV/F+KCNVdl0XOQE+H6LzjoTdPKqhPFq3w
Date:   Thu, 19 Mar 2020 00:51:15 +0000
Message-ID: <MW2PR2101MB105299CD9F7920E09A44BDCCD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-5-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200317132523.1508-5-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-19T00:51:12.8913118Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b093c9a-b239-4357-a996-c7b57a3ab026;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f883d4df-552c-4672-45c1-08d7cb9fa0f5
x-ms-traffictypediagnostic: MW2PR2101MB0924:|MW2PR2101MB0924:|MW2PR2101MB0924:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0924A38CD6441548D4916528D7F40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(8936002)(33656002)(9686003)(86362001)(81166006)(81156014)(4326008)(2906002)(5660300002)(10290500003)(498600001)(71200400001)(6506007)(26005)(8676002)(7696005)(64756008)(52536014)(76116006)(110136005)(66946007)(66556008)(186003)(66476007)(66446008)(55016002)(8990500004)(54906003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lkqw8X7LrAWI2Bfxu2rId6qyLndhtvPMy747gmKJKzQdP1CsSHyH3lGA5n+XGxeH0M0l7jYCgO3CXU3oCmifZgZHzOEG6j3yKlaNConMbBRT2PpD8vOco8cnL3idwzFgw38UvRev2YKhZFVYfhckaKukmczTGUsc50Sdtk20XlmF3Rj34J7ntR6x6vUd8pXEV+0aGyKjTzCqrMdT5qXtPkYEuNfpGqWMwnV8PzOReNlZQa3qtrc2BWCuOV2C+ngHGTtD27Oi3CR2aBITsBaUR0riaDdyvtHcbUNEfg1IyUsl2anfihp9zUosjYRIMKDc7trQ7E8gT9K0Guptp8yYeckiwJk6k3x8T13bjpFXi/B9Pvjfz5TdeJlpgWW2rxQ7xAwip10vS+O+alnIofXd9y1SYcciGze0CPbjHnEmB8CPerteno63GGB5U9rxjOiVWCx8DNt/m3GvGrzx+QSAZ+PxuM53UYg+W6O0uWdqDGCXMByzaDmJRN4HC+AVz9Vs
x-ms-exchange-antispam-messagedata: atLAp2Up5fBCnd7KACuDvpjt7OKxnARCW8C0XK38LVJODXIZNLo6USTJ6KTehEZqxP7vDCkukd/iFgLbJE3sO1cFWiockt+SHkC7PqYGMcGGS9q+JU9XD442QFtmBVTijydqbTysW70vdDvtJ4Fugw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f883d4df-552c-4672-45c1-08d7cb9fa0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:51:15.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7e+DrDGV69U6NcBjTnPKKXI5f+/3kbmHf5bOXdz1w87G291gdHy0gFTaikCTElgqGmT5R4xsrTCCwN+UwVM2P2F/DYVNZ/NajM5U/rsNVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: ltykernel@gmail.com <ltykernel@gmail.com>  Sent: Tuesday, March 17, 2=
020 6:25 AM
>=20
> Hyper-V expects to get crash register data or kmsg via crash
> enlightenment when guest crash happens. crash_kexec_post_notifiers
> is default to be false and crash kernel runs before calling hv
> panic callback and dumping kmsg. In this case, Hyper-V doesn't
> get crash register data or kmsg from guest. Set crash_kexec_post
> _notifiers to be true for Hyper-V VM and fix it.

Suggested wording tweaks:

We want to notify Hyper-V when a Linux guest VM crash occurs, so
there is a record of the crash even when kdump is enabled.   But
crash_kexec_post_notifiers defaults to "false", so the kdump kernel
runs before the notifiers and Hyper-V never gets notified.  Fix this by
always setting crash_kexec_post_notifiers to be true for Hyper-V VMs.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
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

