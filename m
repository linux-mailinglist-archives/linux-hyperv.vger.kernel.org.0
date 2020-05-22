Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05CD1DEDD0
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgEVRCp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 13:02:45 -0400
Received: from mail-eopbgr760123.outbound.protection.outlook.com ([40.107.76.123]:22377
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730665AbgEVRCp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 13:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtA0Y8NvNmfhI5FLsGkSl4U62mXApLMq93vjxGtR/oPxRnUJOdrQ48o9H6+Q1lcwNWXieyO5U4yb/frAC7YXJ89X0tvEn2rZSfuACaIbNGuKGDDA+zC6dqimPOBSJGWNQ4ETJexFFteec3jCaL6PBt/z/1fCSijtbJav0IPg18RUCqq3n4hLEVK76sp+GumEP+2iA3201p1dlLnBufkFaFkwER4rRj8ITt7QXd5Ox0hTfcmPqQzMMqWLwZ9VKu6ArZ0YceWXxTAE6/JNiXHBegUL6IqLE5eOPpW7ELBZstg4BLwvDWTis6jWk/OtJWpcO2PQcDBlJ9pWO9pn01mnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxRs73AASE9Z9C+8Q1D5+ukrLkFXekvF/2evPkAjyZs=;
 b=G4hh4tEswLta36xLwAT/1W6ZdSz9I8iGUDPYcj9T3k3IOtkNoxTQv0abknP7SmMyx861uLpEll2A8tfD8t2VJ4yJmsBVBckRf9zCWExXem7fhZjaCDGUc4Eqiihdjw0P+hAdQ3zdLC7C0L0ox6EUtn81QRvFxjuxK66OkiD/r/9MlaeH/Wz08oaazMTErDRVRzW+JaRAQPGfEq5k0yhpwrCJIsg7st4LiqD94sPIVqhsfbdZFZ1v6xdupanJuJ15lBckPZAUzgulo4LScNF87WlIfvKTSK2iy6dh0Vb+6u9xxNB0PHo6JIvGAXNX6GFwx7JcZJMDsXRb+S7mTdEWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxRs73AASE9Z9C+8Q1D5+ukrLkFXekvF/2evPkAjyZs=;
 b=YNR7pUMwRkwKFlKWNyOfyLCGp6Ik/oYFdrInGznhTRT92OLUsKuB/GRpMLQd+MynKou53zvCvwXnb/GhywF7zUVUxsWN7eNd76V8TogN8Mj7OxijZiqEpNy7/WlY4DF9hj0WJ+xnA1+Vy9vep5UpXuyZQ8oPO00148ouBuJ5RRo=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0815.namprd21.prod.outlook.com
 (2603:10b6:803:51::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.8; Fri, 22 May
 2020 17:02:42 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718%8]) with mapi id 15.20.3045.007; Fri, 22 May 2020
 17:02:42 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Index: AdYuDAEiPLOc+vnoR1KnBaBInLPPAQAePL4AAHTd3lA=
Date:   Fri, 22 May 2020 17:02:41 +0000
Message-ID: <SN4PR2101MB0880E7DD03EF18680A2A88B8C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <87ftbvt21h.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ftbvt21h.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c8ca:a51:eff4:4aba]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 968cffb4-9013-44ec-f398-08d7fe71f0c1
x-ms-traffictypediagnostic: SN4PR2101MB0815:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN4PR2101MB0815745B1E0578B89C477242C0B40@SN4PR2101MB0815.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAWcI9P+/Od7JEJ0hm+J2eKg4rv6QLSJsFAhomW4VxBdyjVCudS1pqGwITS3MeMeerWzUXbSEkYo6VZzEkvj33fraGWaUmKo+YvoU3MKhTbii1UedKm5mxjrKMVOMf0N60dwUaR9QlLfgnabSYVv+UOGJjldSrNP2dgUehhrMyHwr1D96liuJT5dWE10e4iWoFgoaFqq0Rk8fb/9t755/ZQ8C4BCIR4gIWFp77Bs1igJbXBZDa1s9oSZHCOcsy11IFmfu5tSi3DGqP28hKuoitWRD4mHP/7Dazydz3OBGVh5iq4IGobg1JSjD/7PLWXZBfO6d2YXPamjNDVC5ZjKbyVpwETZYTf8oLGOSVj95ePfLD2gWlQwwyAJY9a3sTgdT+Xss2dxc8OIFzaal0//glEh3XOPJ/9nmMzasd/Kpl//NjKE36PMUmYjF748M/rDSn4KQIAUmNv9K2Zh7IDmgGTu5SaizryVm4cXmwJ3uJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(8936002)(4326008)(8676002)(478600001)(107886003)(33656002)(10290500003)(186003)(86362001)(9686003)(8990500004)(71200400001)(2906002)(55016002)(6506007)(82960400001)(82950400001)(5660300002)(66446008)(64756008)(54906003)(6916009)(316002)(52536014)(7696005)(66476007)(66946007)(76116006)(66556008)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ihg5ZqLluExFLrB+4p4or3nza6JqEVFt/0YAr7gzLBdeFHFTkixrgoo6ork/DTWal7RZ4gsb3VfKP8UfX3s221UdEF/d0qZXx3eIxWOLLRC/5tS2jkxr73/AhrtMDGq5oxgRbVQL4++zbACXJ9/SXAFyGsibe3btn0uksnBXiFWpazw3DR0StzkszKYhTG+NJwvIOMoNqO+ofKpmddCF8gZgpMXmNicGyMDrPgzzdcEsB5ny7c4Q2MEmDe/jo+tJmBP2QKhlY+Kb76XVqVGhR8GYhZ7wnPSZE36jRcpF+rIMTNI42FbSLU3UNLoWmrUVthkV3/UWycF0OQbQHpvrDDtFY/lZ3TI7DcejRPaMXBPFLie/DTcUfB9d1XNDXWhhCiDdA9hbI02fIyoJvTXuXcN/Ys75D+uQ1VTD5CUD57TB0lGJScAjRfJIASHkWw+cAqNSYzjBENQszU8HMa8TUzv5PVdYUXJugwcLbhbrbh5RVqRfZVKL3F4aT4DDSkAFqz2M2u546P+fPbVe3hDi7uHbsKMRfz8005LRLzWiEL8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968cffb4-9013-44ec-f398-08d7fe71f0c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 17:02:41.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Q8aECZsjIvvc30Ae04m8VHsi2Yz4Z0+v+Z5DankJwpug3h0JUMljfpCG2YaxoBBodUNpKE0M+smhr4/Sqdz3RnWEdNg+n0iQLX9Fru1OU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0815
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> As the only usage of this function looks like
> if (!(hv_query_ext_cap() & HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT))
>=20
> I would've change the interface to
>=20
> bool hv_query_ext_cap(u64 cap)
>=20
> so the usage would look like
>=20
> if (!(hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT))

Good idea. Will do in v2.

> >  	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
> > +	ms_hyperv.b_features =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
> >  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
> >  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
> >
> > -	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> > -		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> > +	pr_info("Hyper-V: features 0x%x, additional features: 0x%x, hints 0x%=
x, misc 0x%x\n",
> > +		ms_hyperv.features, ms_hyperv.b_features, ms_hyperv.hints,
> > +		ms_hyperv.misc_features);
>=20
> HYPERV_CPUID_FEATURES(0x40000003) EAX and EBX correspond to Partition
> Privilege Flags (TLFS), I'd suggest to take the opportunity and rename
> this to something like 'privilege flags low=3D0x%x high=3D0x%x'.
>=20
> Also, I don't quite like 'ms_hyperv.b_features' as I'll always have to
> look at what it's being assigned to understand what it holds. I'd even
> suggest to rename ms_hyperv.features to ms_hyperv.priv_low and
> ms_hyperv.b_features tp ms_hyperv.priv_high. Or maybe even better, pack
> them to the same 'u64 ms_hyperv.privileges'.

Good idea. I will make the change to rename this to 'priv_high' in v2. I li=
ke the idea of
combining 'features' & 'priv_high' to a u64, but that would be a cleanup ch=
ange and a
separate patch.

>=20
> Why is largepage always '1'?
I have responded to a similar question by Wei. Page reporting only supports=
 huge pages
and, so does the Hyper-V hypervisor. Let's follow this there.

>=20
> > +		range->page.additional_pages =3D (1ull << (order - 9)) - 1;
> > +		range->base_large_pfn =3D page_to_pfn(sg_page(sg)) >> 9;
>=20
> What is '9'? Could you please define it through PAGE_*/HPAGE_* macro?
Yes, I will define a macro. Essentially, it is to get a count of 2M pages.

> Nit: you could've just used
>=20
>         if (status & HV_HYPERCALL_RESULT_MASK !=3D HV_STATUS_SUCCESS) {
Sure, coming in v2.

>         ...
>=20
> > +		pr_err("Cold memory discard hypercall failed with status %llx\n",
> > +			status);
> > +		return -1;
>=20
> -EFAULT or something like it maybe?
Coming in v2.

> > +#ifdef CONFIG_PAGE_REPORTING
> > +	if (enable_page_reporting() < 0)
> > +		goto probe_error;
>=20
> Why? The hyperv-balloon driver itself may still be functional and you
> already set dm_device.pr_dev_info.report to NULL.
An error here would reflect an internal error and should not happen and
it was to make it easy to catch such errors, which are otherwise difficult
with just a print. But, the code should follow the general spirit. I will c=
hange
this in v2.

>=20
> >  enum HV_GENERIC_SET_FORMAT {
> >  	HV_GENERIC_SET_SPARSE_4K,
> >  	HV_GENERIC_SET_ALL,
> > @@ -371,6 +379,12 @@ union hv_gpa_page_range {
>=20
> There is a comment before this structure:
>=20
> /* HvFlushGuestPhysicalAddressList hypercall */
>=20
> which is now obsolete.

I will add that it also applies to 'HvExtCallMemoryHeatHint' hypercall also=
.

>=20
> >  		u64 largepage:1;
> >  		u64 basepfn:52;
> >  	} page;
> > +	struct {
> > +		u64:12;
>=20
> What is this unnamed member? Another 'reserved', 'pad'? Let's name it.

Sure, coming in v2.

>=20
> > +		u64 page_size:1;
> > +		u64 reserved:8;
> > +		u64 base_large_pfn:43;
> > +	};
>=20
> Please name this structure in the union.

Sure, coming in v2.

> > + */
> > +#define HV_MAX_GPA_PAGE_RANGES ((PAGE_SIZE - sizeof(u64)) / \
> > +				sizeof(union hv_gpa_page_range))
> > +
>=20
> The name HV_MAX_GPA_PAGE_RANGES sounds too generic and I think this is
> specific to the HvExtCallMemoryHeatHint hypercall as other hypercalls
> may have a different header length.
>=20

Good idea to rename. Coming in v2.

> > +/* HvExtCallMemoryHeatHint hypercall */
> > +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> > +struct hv_memory_hint {
> > +	u64 type:2;
> > +	u64 reserved:62;
> > +	union hv_gpa_page_range ranges[1];
>=20
> Why '[1]' and not '[]'? If it was '[]' you could've used 'sizeof(struct
> hv_memory_hint)' in HV_MAX_GPA_PAGE_RANGES macro definition instead of
> 'sizeof(u64)'.
>=20
Good idea, coming in v2.

- Sunil
