Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D331F7B5BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2019 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfG3Wfh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jul 2019 18:35:37 -0400
Received: from mail-eopbgr760137.outbound.protection.outlook.com ([40.107.76.137]:50112
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729250AbfG3Wfg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jul 2019 18:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHINN0GywVQ76pMm+T0H1+2k3Cten2gqVmwZiDYaJ1D2TbYdx1JB6aF+eY7nlQd/UTC0TxeR2XSRp3t6rlDIqGiA+ua/6bAToQeksFWu2sYgDxCAYqhc80tMvVTJuNKfBtHY96kYTwdRJ64aMnywLNhBNrSO6ix7P7wWXAYXrcKuI3OTE8fqqjgdeIDuyrZLSuZOU1Cf8NkSeHOh+eFu7nS5y4VzQm6XU00jSWhK9b2WUJLgousXyjE7MI2c08SY0r9Oa+u5axQi+qCzs1Yjmdb8Px9ZFWnoP1Gq81o2nCRWYFpO70L5LFJ5UeMHuIgfCraLxLQ7WWqOzM0MR9X0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+1yELovC6a65+G1g4Vgx5dahXebxJu+feWSwHsXKUo=;
 b=FAodmN7W9gDrPOLWLKYIU7Jc83eHQVs8gnFxY4WOAXgz14bmTNnnV1Kh8Nha0f0efdTjPkvt/2fbSVnik66Q1UqcSipASUu2C5hoYR9ch3AKsS8aONHPRwUX92KQPOO9DWp5G71c+QU8MTms8IY/mR4jx2CRpZt0CZTQtGVbVIS+TmM+4X5oYatunY5EFtzcRsjvCo2D51cZsH1mmQZ0QqkuyFyWvrhxAVg7kWFnh9Hir6XC8lbefJ7IpsPe8ILwikBbsEgDCtot6d8QfATbmZ44M0/rNSR5V+xXJER3yR4h8KtlL4g0QrDwf7L1ZIk65vii0AzGPSJB9qpdYPONMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+1yELovC6a65+G1g4Vgx5dahXebxJu+feWSwHsXKUo=;
 b=aJKEQVdEQNo5nfQLtYGTQdAlT/aFd1MkoYUqVQZLjppObEXmG8VX40oRIkJbIuk57oYWpzESK7WzZCefz91A2ZRhwokZjJta8IS14eJeo+PMqRIGQa9yymmbmIr3OsGjPY1wgKpMcT5aCGM8IiyTTcbt/PS9hZ3gt+bmDkZHoMU=
Received: from MWHPR21MB0784.namprd21.prod.outlook.com (10.173.51.150) by
 MWHPR21MB0144.namprd21.prod.outlook.com (10.173.52.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 30 Jul 2019 22:35:32 +0000
Received: from MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82]) by MWHPR21MB0784.namprd21.prod.outlook.com
 ([fe80::7de1:e6c1:296:4e82%5]) with mapi id 15.20.2157.001; Tue, 30 Jul 2019
 22:35:32 +0000
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
Subject: RE: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into
 regs and timer settings
Thread-Topic: [PATCH 3/7] Drivers: hv: vmbus: Split hv_synic_init/cleanup into
 regs and timer settings
Thread-Index: AQHVNhdHF9iN5SffUkeN3ldh24O58qbj4Fjg
Date:   Tue, 30 Jul 2019 22:35:32 +0000
Message-ID: <MWHPR21MB0784D7CFED4961C5B3D310B4D7DC0@MWHPR21MB0784.namprd21.prod.outlook.com>
References: <1562650084-99874-1-git-send-email-decui@microsoft.com>
 <1562650084-99874-4-git-send-email-decui@microsoft.com>
In-Reply-To: <1562650084-99874-4-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-30T22:35:30.8830380Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b0c3192f-cc83-4b10-908c-c226dbf4abcf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd3d8f4-42e4-48f4-2771-08d7153e3b85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0144;
x-ms-traffictypediagnostic: MWHPR21MB0144:|MWHPR21MB0144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0144B28E06CCC14269EB88F7D7DC0@MWHPR21MB0144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(25786009)(8676002)(305945005)(76116006)(8990500004)(229853002)(256004)(66446008)(8936002)(71200400001)(478600001)(1511001)(53936002)(86362001)(74316002)(66556008)(66476007)(64756008)(71190400001)(66946007)(110136005)(22452003)(316002)(81166006)(81156014)(99286004)(66066001)(186003)(3846002)(6116002)(6246003)(7696005)(102836004)(6506007)(26005)(68736007)(76176011)(486006)(2201001)(14454004)(52536014)(5660300002)(6436002)(55016002)(7736002)(2906002)(4326008)(11346002)(476003)(10090500001)(10290500003)(33656002)(446003)(9686003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0144;H:MWHPR21MB0784.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C8IBlDJeJIwXId7I2HXYJO4AZHMQT/CbkRAHKTUkRzb1exKm3APRPOHSghNg3lFbr1uYSg/8GBrvLLahIIk1YZ9DXkW2oetxLkQOVYKdt1xIBd7mtbKNA5XPB5mp8xntMmmxQbwEEfCe4SuvyIWyZHP3c668ataeP48eUPQntLRTTzeQ8lqa14UjzuRh5pCy7+QiyURN8lZa1x2o16VGXb7886pBtTYC8JvHKNFXjUq20PWnehjZYtNHfaScn+zqLP9BMQUMOlKq1xWR/CYdbr1XNKNiNzgwbHcQcfCUJn9x8o79+ldqoxSjGymiwCse/lJir4egDMxasfy347mYR9/l9QbXrRAUVHwf+wpmHPXD1eH+2Hm4mB7TcNardaLCDNcIBGFZ4hFxB+4cOfQOyb0JyihPg3semVKfro1/x+U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd3d8f4-42e4-48f4-2771-08d7153e3b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 22:35:32.5253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvxV8veBOFpoPvoT0bj2Rq5iVCWUVwzXLP/gYE8r91AY3yvYOtcUkKklK1dBrGoGixLBD1hoNWJ2NjVK2kTckGa6ixhXZY2aPfEegZdPbrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0144
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, July 8, 2019 10:29 PM
>=20
> There is only one functional change: the unnecessary check
> "if (sctrl.enable !=3D 1) return -EFAULT;" is removed, because when we're=
 in
> hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.
>=20
> The new functions hv_synic_disable/enable_regs() will be used by a later =
patch
> to support hibernation.

Seems like this commit message doesn't really describe the main change.
How about:

Break out synic enable and disable operations into separate
hv_synic_disable_regs() and hv_synic_enable_regs() functions for use by a
later patch to support hibernation.

There is no functional change except the unnecessary check
"if (sctrl.enable !=3D 1) return -EFAULT;" is removed, because when we're i=
n
hv_synic_cleanup(), we're absolutely sure sctrl.enable must be 1.

Otherwise,

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/hv.c           | 66 ++++++++++++++++++++++++++---------------=
------
>  drivers/hv/hyperv_vmbus.h |  2 ++
>  2 files changed, 39 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 6188fb7..fcc5279 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -154,7 +154,7 @@ void hv_synic_free(void)
>   * retrieve the initialized message and event pages.  Otherwise, we crea=
te and
>   * initialize the message and event pages.
>   */
> -int hv_synic_init(unsigned int cpu)
> +void hv_synic_enable_regs(unsigned int cpu)
>  {
>  	struct hv_per_cpu_context *hv_cpu
>  		=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -196,6 +196,11 @@ int hv_synic_init(unsigned int cpu)
>  	sctrl.enable =3D 1;
>=20
>  	hv_set_synic_state(sctrl.as_uint64);
> +}
> +
> +int hv_synic_init(unsigned int cpu)
> +{
> +	hv_synic_enable_regs(cpu);
>=20
>  	hv_stimer_init(cpu);
>=20
> @@ -205,20 +210,45 @@ int hv_synic_init(unsigned int cpu)
>  /*
>   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>   */
> -int hv_synic_cleanup(unsigned int cpu)
> +void hv_synic_disable_regs(unsigned int cpu)
>  {
>  	union hv_synic_sint shared_sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_scontrol sctrl;
> +
> +	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +
> +	shared_sint.masked =3D 1;
> +
> +	/* Need to correctly cleanup in the case of SMP!!! */
> +	/* Disable the interrupt */
> +	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> +
> +	hv_get_simp(simp.as_uint64);
> +	simp.simp_enabled =3D 0;
> +	simp.base_simp_gpa =3D 0;
> +
> +	hv_set_simp(simp.as_uint64);
> +
> +	hv_get_siefp(siefp.as_uint64);
> +	siefp.siefp_enabled =3D 0;
> +	siefp.base_siefp_gpa =3D 0;
> +
> +	hv_set_siefp(siefp.as_uint64);
> +
> +	/* Disable the global synic bit */
> +	hv_get_synic_state(sctrl.as_uint64);
> +	sctrl.enable =3D 0;
> +	hv_set_synic_state(sctrl.as_uint64);
> +}
> +
> +int hv_synic_cleanup(unsigned int cpu)
> +{
>  	struct vmbus_channel *channel, *sc;
>  	bool channel_found =3D false;
>  	unsigned long flags;
>=20
> -	hv_get_synic_state(sctrl.as_uint64);
> -	if (sctrl.enable !=3D 1)
> -		return -EFAULT;
> -
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
>  	 * cleanup. In case we find one and vmbus is still connected we need to
> @@ -249,29 +279,7 @@ int hv_synic_cleanup(unsigned int cpu)
>=20
>  	hv_stimer_cleanup(cpu);
>=20
> -	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> -
> -	shared_sint.masked =3D 1;
> -
> -	/* Need to correctly cleanup in the case of SMP!!! */
> -	/* Disable the interrupt */
> -	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
> -
> -	hv_get_simp(simp.as_uint64);
> -	simp.simp_enabled =3D 0;
> -	simp.base_simp_gpa =3D 0;
> -
> -	hv_set_simp(simp.as_uint64);
> -
> -	hv_get_siefp(siefp.as_uint64);
> -	siefp.siefp_enabled =3D 0;
> -	siefp.base_siefp_gpa =3D 0;
> -
> -	hv_set_siefp(siefp.as_uint64);
> -
> -	/* Disable the global synic bit */
> -	sctrl.enable =3D 0;
> -	hv_set_synic_state(sctrl.as_uint64);
> +	hv_synic_disable_regs(cpu);
>=20
>  	return 0;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 362e70e..26ea161 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -171,8 +171,10 @@ extern int hv_post_message(union hv_connection_id
> connection_id,
>=20
>  extern void hv_synic_free(void);
>=20
> +extern void hv_synic_enable_regs(unsigned int cpu);
>  extern int hv_synic_init(unsigned int cpu);
>=20
> +extern void hv_synic_disable_regs(unsigned int cpu);
>  extern int hv_synic_cleanup(unsigned int cpu);
>=20
>  /* Interface */
> --
> 1.8.3.1

