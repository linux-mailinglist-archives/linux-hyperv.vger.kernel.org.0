Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DB18FB1C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCWRPf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 13:15:35 -0400
Received: from mail-dm6nam11on2116.outbound.protection.outlook.com ([40.107.223.116]:11297
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbgCWRPf (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 13:15:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3Qm5fQGq9Zm2g9BMLw63TeqB7zZqtWOyW8g6STFf3asgWQFYqKl0KhHc57ugpLkDukg28pv6n/SmGhWP9G76OTyQwNdbYMEXfUtcfdnbH8VoH/Tc6Sc/28GW5UVadjN9+svmAMKawfk6mAhhh4oLEOyGXrQ9kbK1qYlG04xGxflyHRmbF1mjTqJZnMQohW95cuiGA8NC+3ry7XohHT7hIVIDxgjM3KOLUly7CW+Wn0snKd3EsG2UM4HWx4Fp/1G7Htpx2TKO08GEcJ9fK7+Aq5cX4X5vGSS1ltpbAnAiCmr9d6vzaxqPQD20hJVKcu6MJ+BskCVoFu1fAfB1oEWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZjL2sUlH6xamWUhPhJj6PEMBp/CBL/NPjHT1wTyuvw=;
 b=LRtB6ErPVlt/Ja+X+vxh4dUoV2VTmAHfTC72sKuzf4IIlG/u0gLFkbfKQBKAkxOigG9EcgLteo+C53p+yDLVtFYm0QDrsAG2AvwAWvck39/IUAbQza7VSuDJqi/P4r/5/Am/FueUqPvlTkRvstXirfLnMmj4/Ke8xPQ1/4HDv2+pjunjf/U+8OlpoW8gesNBzYatfDxXGHv9n64ma5IaXn6FWnEz451yF16rKHNssmhkYFB3G21t3zRlv2FsQ/twbIyVX9+3TvC+g04AxwL07nyzM3ruwtaLLsnFXbNHRnK7yKg8JnJ/2tL9TJ9ZmZjJ70EO+S3B/tzILf0bLOF9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZjL2sUlH6xamWUhPhJj6PEMBp/CBL/NPjHT1wTyuvw=;
 b=LZBuR3ddT5x7xm44Qm/wEKcuw6MW2efjO/43QcD0tlph+pOQ+3dkwSXcYtdQQRjq+p3Vd4CT7y9re1sFZq4kQmWgOAZxdyxYSNPe8kVZK8hb5eENktGDPuKSIP2aDhHvwIzBcG61cqqBF3woB4bPaYDtx5ummibWcvlUUxPK3io=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1051.namprd21.prod.outlook.com (2603:10b6:302:a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.3; Mon, 23 Mar
 2020 17:15:32 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 17:15:32 +0000
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
Subject: RE: [PATCH V2 3/6] x86/Hyper-V: Trigger crash enlightenment only once
 during  system crash.
Thread-Topic: [PATCH V2 3/6] x86/Hyper-V: Trigger crash enlightenment only
 once during  system crash.
Thread-Index: AQHWARRUpT76HZv44kGCHGoJXYag3KhWai3A
Date:   Mon, 23 Mar 2020 17:15:31 +0000
Message-ID: <MW2PR2101MB1052F05D33BBAB54B25CBE66D7F00@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
 <20200323130924.2968-4-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200323130924.2968-4-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T17:15:29.9336244Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87bb2f05-4794-4cf0-b3b3-6d08018f222a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ff67fea-6a59-437e-3b56-08d7cf4dcafb
x-ms-traffictypediagnostic: MW2PR2101MB1051:|MW2PR2101MB1051:|MW2PR2101MB1051:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10511E8A7BAD9F929F21AA28D7F00@MW2PR2101MB1051.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:213;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(54906003)(110136005)(66946007)(81166006)(6506007)(81156014)(71200400001)(316002)(33656002)(8676002)(4326008)(8990500004)(9686003)(55016002)(66476007)(66556008)(64756008)(66446008)(86362001)(76116006)(10290500003)(7696005)(5660300002)(8936002)(26005)(2906002)(186003)(52536014)(478600001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1051;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7OzQZJNEOGssXctqSN/2uC/oZt00H1vHZkUpuqVL9sCmnj4ROj62yqD1XWMAA74ARz91+OLShJazx6fTa2PxvH9SJhZNe09I2B+ewdbBt389sjd9w7ppJxsrXEZhsmrxdMFVM9tOIzULlh7x6EVjsjuuKl3EyaVo6BuKeeu5D3Jydb6UhUFp1C6E5rnNI5Lf/8Q+k1nuFnWatNYqIR4Qo/MmwpiinVa/7IckDV4mWiyX2j+46GGe53KLDFlrU+3HqdGsL7ahy7Fa3veLiD2aYO8eH9+eiJuGp7blr/JiIWPW90pnyZWjRi6rp5T6QlZtrwtHBzJaBkGZs2WPgQlVIhA8a/gsxh1rY6YPWGyHNl6rYcnSgESeFKrrGVItFtzkw07/5p40d0ZpOnlhhFDjIk4lPRP5h/FclwcD7/9dbOnyei0d2RQF44KmfkemiFq/AZXqqc+RAP8PFynSylION+qU6eRM+EL80enHic4T75uk8hRMvsFyxouLqpuGyJkl
x-ms-exchange-antispam-messagedata: h/2XRq+aFisFzlMSjgYblaOGJR8AQkfRJbjvYiMT3ATfxjUxpEGNDiRO14ZWneC+bjVu+RFhu0+vf8LcsdViLjGpFUywu5LNowmkFVIbsrd6pX1fSHQm2xZuJLEVQ/qPfSS2ATOFcoPYGBk3AoXnhA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff67fea-6a59-437e-3b56-08d7cf4dcafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 17:15:31.9049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBZUBJIAdlF4cpPWpjw9hz4t+dj4QcQzvGO3CfhgZZb12/lIstaHK4toeY6Ff40fPFIvTWAHSwAb+I9f0N44HENFXEzc4Nn96DjqqvaKwBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1051
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
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	- Update commit log
> ---
>  drivers/hv/vmbus_drv.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3a0472c8b7ae..d73fa8aa00a3 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -55,7 +55,12 @@ static int hyperv_panic_event(struct notifier_block *n=
b, unsigned
> long val,
>=20
>  	vmbus_initiate_unload(true);
>=20
> -	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +	/*
> +	 * Crash notify only can be triggered once. If crash notify
> +	 * message is available, just report kmsg to crash buffer.
> +	 */

Just to clarify the above comment, let me suggest:

	/*
	 * Hyper-V should be notified only once about a panic.  If we will be
	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
	 * the notification here.
	 */

> +	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
> +	    && !hv_panic_page) {
>  		regs =3D current_pt_regs();
>  		hyperv_report_panic(regs, val);
>  	}
> @@ -68,7 +73,12 @@ static int hyperv_die_event(struct notifier_block *nb,=
 unsigned long
> val,
>  	struct die_args *die =3D (struct die_args *)args;
>  	struct pt_regs *regs =3D die->regs;
>=20
> -	hyperv_report_panic(regs, val);
> +	/*
> +	 * Crash notify only can be triggered once. If crash notify
> +	 * message is available, just report kmsg to crash buffer.
> +	 */

Same suggested clarification to the comment applies here.

> +	if (!hv_panic_page)
> +		hyperv_report_panic(regs, val);
>  	return NOTIFY_DONE;
>  }
>=20
> --
> 2.14.5

