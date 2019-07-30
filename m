Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772AF7B5AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 00:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbfG3WYF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 18:24:05 -0400
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:59661
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387473AbfG3WYF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 18:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egCXrqNiZ8igttAKc4CJkbmuSJDLlFU1CJBj74CqIE4DaRf6XCT+L+2zMS2o5XAJ9k95hFST9AoHuh8OA6tu9Ie2oTj/e9wure4fHr0OZS8WoGMjasIkTor9A+eRdCniV5PJRWQJ2odTgqC4nkTgHXIqg+C2vcjdaC1Ekgb4sLDsrfZ/r+bKfSJteMA15DXUKeWSWf05eHF5faDbK+VpEQoP2qn8KwSdDG4BpPXt2luxAzVT6mApaE+TO5HRHfFlFgOi4yIQ4g2pkzqvSubPz3CjaBtTOV9bVVl7LIW4qthzl56QupeRT31d8h850F3Fnr4XTIhmdAgxH9oEF5aAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q69qMVLCI2+3TDFzc3i2iuupur4atNeSoClNARI7zOs=;
 b=QkPew7AYvWU9+iwMuvFVV/cKgTJ3hzJz3aRydhgVhxo7Cp8RpCe8uET6RY5VrS7qMTz3Y7qqhGujv3SXSCIgzNtH3PeAirDJjWxHyfO+LgFWnccK+vSmUl9kqb3h4XZapJFn6to10USeK6koJMu2spSohihGJsD200JQSrsKFRw3kxu5MnvDyHwl7pzpEc85vyHb1SWqrmaM8XGNka/BhyiOHtsR24hZpyjzAkwDP5zM/viTk1rXH7rTRmcp4c+L6gbt8bP0/dA3als1Qjp3mmFa5C+/Y5J83RKlYlHxiEOvsrzaFgLCHI2XgIQwIG2Cnoi+k/R+w8H3feNoEHRIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q69qMVLCI2+3TDFzc3i2iuupur4atNeSoClNARI7zOs=;
 b=kkaSFmy6Rdh/0qwtVwRsxOeuJ72p2iZjnTggclih5BwNEy6r52EaR5oofg+WrSZlrkQF2oX8WXmql9k8D7RtFG5O8hZQj7+eSkKGSiGJ2cONJ65PtlRjnQXzZVIz6iYTkbMQqrvNFRV419IXZ74yHARmU/Jb53nfane+sm7AVwY=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0158.namprd21.prod.outlook.com (10.173.52.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 22:23:23 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 22:23:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Topic: [PATCH 2/7] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Thread-Index: AQHVNhdGDMbLoRwEBkehuKx5BQIVXabj3iaQ
Date:   Tue, 30 Jul 2019 22:23:23 +0000
Message-ID: <MWHPR21MB0784EBA3631A184D23CF6260D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T22:23:21.8288497Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fee455b-ec39-47b6-8293-ddce2c066310;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 053f08b3-b1cd-4023-f5b3-08d7153c88df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0158;
x-ms-traffictypediagnostic: MWHPR21MB0158:|MWHPR21MB0158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0158F1390C79942F710EF892D7DC0@MWHPR21MB0158.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(55016002)(102836004)(2501003)(25786009)(76116006)(66066001)(4326008)(66446008)(7696005)(6116002)(74316002)(14444005)(8990500004)(1511001)(10090500001)(229853002)(305945005)(3846002)(256004)(66476007)(15650500001)(316002)(66556008)(110136005)(64756008)(5660300002)(14454004)(68736007)(86362001)(52536014)(9686003)(486006)(446003)(11346002)(76176011)(66946007)(478600001)(2906002)(99286004)(10290500003)(22452003)(33656002)(71190400001)(7736002)(81156014)(53936002)(6246003)(6506007)(186003)(8936002)(8676002)(2201001)(71200400001)(26005)(81166006)(476003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0158;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gNjFFKwuf5/VATx/SWkC3HkwIBzPj4rgaymWhXUC3Pmmz0GpHBe5Wc8DqZdxqRpuzYgZ3dr5u1VX8RejShKaEH6rSIyYTNMWxrfvJxukjecAuXmQmJ6oppGxpLV8U1jNg41OkaqAnqffypdfqBYJxtD/cMokCw0jPJEG1BqgLJ1XEr0/wRCnGxcEtqevI8KNQgp6YiHY7xm/6TrboLcvqMIa7RO+qaf9ds61isoe8Kq4Fvp4lOW+GRIjaeL8c+zucHPRJHNBtK7VJ8ibPj+D0Dv0Twc5RzPNdgE1RLAsZLLqUdW+1a3JPZPlXgIhef5RswpYF5Dz4DPrtTUmYVqBVbu28arVmkGBxiM3GiAz9dezoVyN6qWXTJTUqDj8UzZ5GsOjIJl5elZPCKbZSqXCpCRZxPMl3dBqEC9vriNfC50=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053f08b3-b1cd-4023-f5b3-08d7153c88df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 22:23:23.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +m6zZkvaacfGghCPTcNclEgr/6/ecMGRZorOZuw83r311bpXU6heDy75UJGX6mgOgeeQYl4ZB7Jz7HJkGT2WNTb08jAtmNx+5Yq0+2vxw3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0158
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, July 8, 2019 10:29 PM
>=20
> This is needed for hibernation, e.g. when we resume the old kernel, we ne=
ed
> to disable the "current" kernel's TSC page and then resume the old kernel=
's.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index ba2c79e6..41c31a7 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -237,12 +237,37 @@ static u64 read_hv_clock_tsc(struct clocksource *ar=
g)
>  	return read_hv_sched_clock_tsc();
>  }
>=20
> +static void suspend_hv_clock_tsc(struct clocksource *arg)
> +{
> +	u64 tsc_msr;
> +
> +	/* Disable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &=3D ~BIT_ULL(0);
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
> +
> +static void resume_hv_clock_tsc(struct clocksource *arg)
> +{
> +	phys_addr_t phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
> +	u64 tsc_msr;
> +
> +	/* Re-enable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &=3D GENMASK_ULL(11, 0);
> +	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
>  static struct clocksource hyperv_cs_tsc =3D {
>  	.name	=3D "hyperv_clocksource_tsc_page",
>  	.rating	=3D 400,
>  	.read	=3D read_hv_clock_tsc,
>  	.mask	=3D CLOCKSOURCE_MASK(64),
>  	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
> +	.suspend=3D suspend_hv_clock_tsc,
> +	.resume	=3D resume_hv_clock_tsc,
>  };
>  #endif
>=20
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

