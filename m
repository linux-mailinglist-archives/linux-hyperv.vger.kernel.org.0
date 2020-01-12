Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0B138712
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Jan 2020 17:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgALQn0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Jan 2020 11:43:26 -0500
Received: from mail-eopbgr700090.outbound.protection.outlook.com ([40.107.70.90]:13024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbgALQn0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Jan 2020 11:43:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0YsNwDWRd9tNOU9Nz39jPPi+yrixtWvBuqlXwg/7gX88/LCm5UTEliIcKAz60TzwbkzA7cGjCfwRb+mUccnDBjZqfqJee1pnlr8So/wvJEH1z4pIJNPr5IX9LVt+bPQv0799hIlAa2thTOA55BTvsDETRcB9cczxYPidvfviHM1pmbTcjCSQ0ubcWpPETxAixe+W+8gurxpk2FCw0S3d1p1CiNsIWxBDHAjOGGg5hgbf44F8PKfdfj+br8u1z8uf9lWXkNx9yJRitOrjxT9SUdgjFsjkVab5YAsd0wZVRIJWvcH756qvO/XLvY7/SAs3fkG4R2+MkXAPhrPry2xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d1Vv+05oaBbNi/Xnb4oUjOr4Nh3KmsSeux5wgqMVsw=;
 b=NJbeUH/vMxUicJTZeTlsLbd+qNUbzgR62hmnnM2e/Fwk1aFIu6VUjCueaZgaqw4s5MDLfPtD43WfQnLslmd/5l8/M2wm9WfS8B64VTNbKeNE+X/bic/9H5D4YYGdr86PifsLC7b5eWl7GRWoK3i+XpUg1BTODL09Se4ApDmAGhDTANbhtJXbLqhnMpSLbYrH97ZJKE26917tPvevapr5ZCEmi82Mtn7OQu6jz7S672ztUAq5rQSJ/BwNhYFdp+pCtKflz7Wo7zk1nAiiNpjmzZgMFY9Z+5OQfDIqAVhNYeAmZdnyppwgcEBJvpZt4RInLorox/JdV1EWmRJahI3WPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d1Vv+05oaBbNi/Xnb4oUjOr4Nh3KmsSeux5wgqMVsw=;
 b=JVN6K9TOBkaBuPVr8Kyk+A94I8WAzDEToLr3xjfkw1HU1cKpaTOk/2UJV6KSoKun2jm7uAf5QBCaW9kbpcGKXrsYU+HxMGKgh+EpxhDOdkAa2+3vUrCC9g0DOCxiD1IJ1STmAwmcW6kpPmA0d1Pr6Iq7fiUV7tKEYg46B+p5PAE=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (52.132.146.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Sun, 12 Jan 2020 16:43:23 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.011; Sun, 12 Jan 2020
 16:43:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Chen Zhou <chenzhou10@huawei.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenzhou10@huawei.com" <chenzhou10@huawei.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
Thread-Topic: [PATCH] x86/hyper-v: remove unnecessary conversions to bool
Thread-Index: AQHVx4caLzDM/tqZiU6rmM28RHVqmKfjy+iAgANw7TA=
Date:   Sun, 12 Jan 2020 16:43:23 +0000
Message-ID: <MW2PR2101MB1052B01B542F0C0A576928CBD73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200110072047.85398-1-chenzhou10@huawei.com>
 <875zhjr074.fsf@vitty.brq.redhat.com>
In-Reply-To: <875zhjr074.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-12T16:43:21.3026999Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2c6cfc7-fb8c-45da-8f7b-257dbab9522b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fac34d6-dd27-4ed8-2365-08d7977e8a23
x-ms-traffictypediagnostic: MW2PR2101MB1019:|MW2PR2101MB1019:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1019D87D0DB8D9C8525552B1D73A0@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02801ACE41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(54906003)(8936002)(110136005)(71200400001)(5660300002)(52536014)(8676002)(316002)(81166006)(81156014)(8990500004)(2906002)(76116006)(7696005)(64756008)(66446008)(66556008)(9686003)(66476007)(33656002)(6506007)(186003)(66946007)(26005)(55016002)(10290500003)(4326008)(86362001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXcPu32DcFWd1V6uvKCDfUj0vw4YCuROHVTGznvFViiKxuEaWa1l9IYtA7Uaq2uMHsA/ZsPVoj7qljJq+pjs/MQGIE4Bnug16CebVNHCYe+/RnF0Xw91mwHkkdWIgKookA27JTzChRWN7wrP5wSlp/y+qKxR9YENI23GWK3X2bYHyYhgtmRbNAlWmnpNCG+/U2QGQakeq4MUna703PeAvQsUWVKG0FOj0KqwsrT7M8xuu5D80RbAU6LvoF7D/mXFL1/5Yi5bA64iQx94HHimxxJVGfkhCTohV7QyuNkY0lgPFKQtsuljFyQaJZy02zDAN0Q+xNnj8Us/8pvNfWHgnPT1M6VsJmvbZpY9AIDzkDGE2QzOmrPnS8vU2XH4pwArBh3yrNcI/uohFRNND6coAP4sbFlkADla5dIjNPsPA9sXO8Te427hRq1MyJkzQR1S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fac34d6-dd27-4ed8-2365-08d7977e8a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2020 16:43:23.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLqrGlpF4ID7FpjmnN5Ma1Erd6t0EWLI8sAS640+vflD4eSb7iYcma3LX6sPpQ5xGw4UVVK63IeY7cmhnpLLiINf4DBGKDtwNr0mZzTEQbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 10, 2020=
 4:00 AM
>=20
> Chen Zhou <chenzhou10@huawei.com> writes:
>=20
> > The conversions to bool are not needed, remove these.
> >
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > ---
> >  arch/x86/hyperv/hv_apic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> > index 40e0e32..3112cf6 100644
> > --- a/arch/x86/hyperv/hv_apic.c
> > +++ b/arch/x86/hyperv/hv_apic.c
> > @@ -133,7 +133,7 @@ static bool __send_ipi_mask_ex(const struct cpumask=
 *mask, int
> vector)
> >
> >  ipi_mask_ex_done:
> >  	local_irq_restore(flags);
> > -	return ((ret =3D=3D 0) ? true : false);
> > +	return ret =3D=3D 0;
> >  }
> >
> >  static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> > @@ -186,7 +186,7 @@ static bool __send_ipi_mask(const struct cpumask *m=
ask, int
> vector)
> >
> >  	ret =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> >  				     ipi_arg.cpu_mask);
> > -	return ((ret =3D=3D 0) ? true : false);
> > +	return ret =3D=3D 0;
> >
> >  do_ex_hypercall:
> >  	return __send_ipi_mask_ex(mask, vector);
>=20
> I'd suggest we get rid of bool functions completely instead, something
> like (untested):

Just curious:  Why prefer returning a u16 instead of a bool?  To avoid
having to test 'ret' for zero in the return statements, or is there some
broader reason?

>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 40e0e322161d..440bda338763 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -97,16 +97,16 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
>  /*
>   * IPI implementation on Hyper-V.
>   */
> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> +static u16 __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>  {
>  	struct hv_send_ipi_ex **arg;
>  	struct hv_send_ipi_ex *ipi_arg;
>  	unsigned long flags;
>  	int nr_bank =3D 0;
> -	int ret =3D 1;
> +	u16 ret;
>=20
>  	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
> -		return false;
> +		return U16_MAX;
>=20
>  	local_irq_save(flags);
>  	arg =3D (struct hv_send_ipi_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
> @@ -129,29 +129,28 @@ static bool __send_ipi_mask_ex(const struct cpumask=
 *mask, int
> vector)
>  		ipi_arg->vp_set.format =3D HV_GENERIC_SET_ALL;
>=20
>  	ret =3D hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
> -			      ipi_arg, NULL);
> +				  ipi_arg, NULL);
>=20
>  ipi_mask_ex_done:
>  	local_irq_restore(flags);
> -	return ((ret =3D=3D 0) ? true : false);
> +	return ret;
>  }
>=20
> -static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> +static u16 __send_ipi_mask(const struct cpumask *mask, int vector)
>  {
>  	int cur_cpu, vcpu;
>  	struct hv_send_ipi ipi_arg;
> -	int ret =3D 1;
>=20
>  	trace_hyperv_send_ipi_mask(mask, vector);
>=20
>  	if (cpumask_empty(mask))
> -		return true;
> +		return 0;
>=20
>  	if (!hv_hypercall_pg)
> -		return false;
> +		return U16_MAX;
>=20
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> -		return false;
> +		return U16_MAX;
>=20
>  	/*
>  	 * From the supplied CPU set we need to figure out if we can get away
> @@ -172,7 +171,7 @@ static bool __send_ipi_mask(const struct cpumask *mas=
k, int
> vector)
>  	for_each_cpu(cur_cpu, mask) {
>  		vcpu =3D hv_cpu_number_to_vp_number(cur_cpu);
>  		if (vcpu =3D=3D VP_INVAL)
> -			return false;
> +			return U16_MAX;
>=20
>  		/*
>  		 * This particular version of the IPI hypercall can
> @@ -184,41 +183,40 @@ static bool __send_ipi_mask(const struct cpumask *m=
ask, int
> vector)
>  		__set_bit(vcpu, (unsigned long *)&ipi_arg.cpu_mask);
>  	}
>=20
> -	ret =3D hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> -				     ipi_arg.cpu_mask);
> -	return ((ret =3D=3D 0) ? true : false);
> +	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, ipi_arg.vector,
> +					   ipi_arg.cpu_mask);

The cast to u16 seems a bit dangerous. The hypercall status code is indeed
returned in the low 16 bits of the hypercall result value, so it works, and
maybe that is why you suggested u16 as the function return value.  But it
is a non-obvious assumption. =20

Michael

>=20
>  do_ex_hypercall:
>  	return __send_ipi_mask_ex(mask, vector);
>  }
>=20
> -static bool __send_ipi_one(int cpu, int vector)
> +static u16 __send_ipi_one(int cpu, int vector)
>  {
>  	int vp =3D hv_cpu_number_to_vp_number(cpu);
>=20
>  	trace_hyperv_send_ipi_one(cpu, vector);
>=20
>  	if (!hv_hypercall_pg || (vp =3D=3D VP_INVAL))
> -		return false;
> +		return U16_MAX;
>=20
>  	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
> -		return false;
> +		return U16_MAX;
>=20
>  	if (vp >=3D 64)
>  		return __send_ipi_mask_ex(cpumask_of(cpu), vector);
>=20
> -	return !hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp));
> +	return (u16)hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector, BIT_ULL(vp)=
);
>  }
>=20
>  static void hv_send_ipi(int cpu, int vector)
>  {
> -	if (!__send_ipi_one(cpu, vector))
> +	if (__send_ipi_one(cpu, vector))
>  		orig_apic.send_IPI(cpu, vector);
>  }
>=20
>  static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
>  {
> -	if (!__send_ipi_mask(mask, vector))
> +	if (__send_ipi_mask(mask, vector))
>  		orig_apic.send_IPI_mask(mask, vector);
>  }
>=20
> @@ -231,7 +229,7 @@ static void hv_send_ipi_mask_allbutself(const struct =
cpumask
> *mask, int vector)
>  	cpumask_copy(&new_mask, mask);
>  	cpumask_clear_cpu(this_cpu, &new_mask);
>  	local_mask =3D &new_mask;
> -	if (!__send_ipi_mask(local_mask, vector))
> +	if (__send_ipi_mask(local_mask, vector))
>  		orig_apic.send_IPI_mask_allbutself(mask, vector);
>  }
>=20
> @@ -242,13 +240,13 @@ static void hv_send_ipi_allbutself(int vector)
>=20
>  static void hv_send_ipi_all(int vector)
>  {
> -	if (!__send_ipi_mask(cpu_online_mask, vector))
> +	if (__send_ipi_mask(cpu_online_mask, vector))
>  		orig_apic.send_IPI_all(vector);
>  }
>=20
>  static void hv_send_ipi_self(int vector)
>  {
> -	if (!__send_ipi_one(smp_processor_id(), vector))
> +	if (__send_ipi_one(smp_processor_id(), vector))
>  		orig_apic.send_IPI_self(vector);
>  }
>=20
> --
> Vitaly

