Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D437618FB
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jul 2019 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfGHBlw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 7 Jul 2019 21:41:52 -0400
Received: from mail-eopbgr800119.outbound.protection.outlook.com ([40.107.80.119]:64353
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbfGHBlw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 7 Jul 2019 21:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVA/r2+ALfO7VQWB8oMAI4zGaJkQhp6VVrCAzGCV5Okeebczefh2F1JY9Wx6yv/Mi1nCjyWRM7BeEK5ifWO9lZh93gIeRpP1zi6muRp5+XVheVR5DuaE3dI/rjgzQUZNZYLGCmH8GyGM0bJV9xHbfa5aMcYLQ0PFfTCnmPdKi0jWBH04EtTP1CkF2rjkEIvuVkBOe+EoY7n7jK+BRRB30Do9alaNbcEmje+Z/xvrzr+jwLNVoCpPaPyaZh1biDqw0CS6E2v4q6ds8jSMMGrP/E1s1epIrcKYIG0pOudcGSaKYov9lKEqJouFMUn7r98nzYzmbDk7mTdGmFdWHdNqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujGkaU6Nz5KvBy9uJj3FzRAHOdIXvNK5tXxbnFOpsts=;
 b=kfXWd7utglJrfY1pQubu5aahVGH8RbGVoh05h3xVMCL0QufpTHyqmFMq4LEkcoVkG11fTeXUXY3GOpD4k0owh5XIi0Ns6mtZJ5cO88xUhhBm6U0+s0j8cd3FoxVz7aGQcNoqUDWjxCMz3y23GLk1KHcrl5Uy8d/yoON3UEeRmlm9HSp74mp65suOrh0IMlALVAArdp+lbB4xFV+AkAt2ym5Fk0jYrNyBUsS2TFjgzFFCScEojTOGLXMhYU/bV8+L041Yd9OLSmXHwJJSAP+Awd14EfHHnB7NnCPH+tDzyideZNnmPcho0X3WwPfED/8YjaX5K6cgeoPOYjcYblU2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujGkaU6Nz5KvBy9uJj3FzRAHOdIXvNK5tXxbnFOpsts=;
 b=SR7Se+WeFcPiMX9mUyUL/rzx9YL4XqQF+0P/zr3j8zH4VksmztuFWMuSMl7xp7Wt44ktV38fDwhEJDKV+PRgdX2U7VPev8iT3eddkUBi/sWACKTKmt6sULdtVyNqebzCKNH7VYmWvnOD8GUpDkTCnL2WtW4clfMPVOdG43NHiH4=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0510.namprd21.prod.outlook.com (10.172.95.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Mon, 8 Jul 2019 01:41:49 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::69c0:8cb:908c:f221]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::69c0:8cb:908c:f221%8]) with mapi id 15.20.2094.001; Mon, 8 Jul 2019
 01:41:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Topic: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
Thread-Index: AdUyCb6p1/Ch6raqSV2uCwYf/NBGWgDJF5Jg
Date:   Mon, 8 Jul 2019 01:41:49 +0000
Message-ID: <MWHPR21MB0784896C72E9773B16C2C32CD7F60@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-04T01:45:38.3267647Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85e22f80-189c-4798-b8a7-1089c5ef2a54;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd74ab7-0f4e-41a5-38ed-08d7034571e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0510;
x-ms-traffictypediagnostic: MWHPR21MB0510:|MWHPR21MB0510:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0510CEF6BE8C65B609AD4923D7F60@MWHPR21MB0510.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(66066001)(10090500001)(486006)(9686003)(55016002)(476003)(7696005)(478600001)(74316002)(53936002)(2906002)(7736002)(446003)(11346002)(305945005)(81166006)(81156014)(8936002)(7416002)(99286004)(8990500004)(4326008)(6246003)(71190400001)(71200400001)(86362001)(8676002)(5660300002)(33656002)(186003)(68736007)(52536014)(10290500003)(6436002)(66446008)(14454004)(66946007)(66476007)(66556008)(64756008)(73956011)(316002)(76116006)(22452003)(1511001)(256004)(14444005)(6506007)(54906003)(3846002)(6116002)(76176011)(25786009)(110136005)(229853002)(102836004)(2501003)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0510;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: llMF6fXolPh2Yn6tWTzdJGRx+1hoq41KJnmv8gHxKaYr3umJt08loagIDRihBVE2dNVKlayAv7IXrkEVdJUKUu3gg3Qor82MMU80cxWJa7kEdVcPPGC9QD3/jKptq3LFfzBn3iv3QPD8eyIBzYiL3iBSfgMFVy9pwnqYrASxFCJ1DuuP1LPAtOYc34wQJD89WgS/wSAN3YLUdyCBxnUTNI0LL11y/e6RYK+3cUmzgSHaltPkW/k4R9BNFoZbQXpwcHRTJXh8VgaUEj/YvsZ7YPwemMlD1m0MOJxlWwOUfP4lR3lKqfLGRqzcpxIKOPpdXHb4sTieCntVlaKVxyaXxxCTRskdBf1MkFlhEHu9tEh+eCtbj3ClBbhgTzkMXW2ymRQYvxv4RBLLwHAeaicuA38kI1cGT6SewSK0ZSeWdiU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd74ab7-0f4e-41a5-38ed-08d7034571e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 01:41:49.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0510
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, July 3, 2019 6:46 P=
M
>=20
> When a CPU is being offlined, the CPU usually still receives a few
> interrupts (e.g. reschedule IPIs), after hv_cpu_die() disables the
> HV_X64_MSR_VP_ASSIST_PAGE, so hv_apic_eoi_write() may not write the EOI
> MSR, if the apic_assist field's bit0 happens to be 1; as a result, Hyper-=
V
> may not be able to deliver all the interrupts to the CPU, and the CPU may
> not be stopped, and the kernel will hang soon.
>=20
> The VP ASSIST PAGE is an "overlay" page (see Hyper-V TLFS's Section
> 5.2.1 "GPA Overlay Pages"), so with this fix we're sure the apic_assist
> field is still zero, after the VP ASSIST PAGE is disabled.
>=20
> Fixes: ba696429d290 ("x86/hyper-v: Implement EOI assist")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0e033ef11a9f..db51a301f759 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -60,8 +60,14 @@ static int hv_cpu_init(unsigned int cpu)
>  	if (!hv_vp_assist_page)
>  		return 0;
>=20
> +	/*
> +	 * The ZERO flag is necessary, because in the case of CPU offlining
> +	 * the page can still be used by hv_apic_eoi_write() for a while,
> +	 * after the VP ASSIST PAGE is disabled in hv_cpu_die().
> +	 */
>  	if (!*hvp)
> -		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
> +		*hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> +				 PAGE_KERNEL);
>=20
>  	if (*hvp) {
>  		u64 val;
> --
> 2.19.1

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

