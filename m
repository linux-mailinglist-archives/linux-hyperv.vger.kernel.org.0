Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE71DED78
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgEVQkU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 12:40:20 -0400
Received: from mail-bn7nam10on2132.outbound.protection.outlook.com ([40.107.92.132]:9120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730291AbgEVQkT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 12:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heBvHK8bGiSxQF1i7mgyr1YbwZWVbNjKvNKER7QIKqHJrQLzLuA1n6+7DgtaIfvLmV5YxqurJs3GoR8enSBNaLTVltKrK7kfwqoFEcJnsriA35rP8w+Wy9M6O2shqX0Utz/eM+nMWZtNvsaei337LsWRPVY415+oDuFwfF8DkMb8iTMsIp/8UpgEII3VKGOpM44XzVG8MJJRRAPtPgVtHQ0C5uPTfalhKEfa931IUEoJW9JCS2dw1YXH8tiH0LWy7KDuTmkhoD4uFS/ZxbsocEZjuLC8X0GhqODQARgLwYKZkb83OYDF/JkSv4z3lFsbaii6jxMg+j8cxhGY9VbBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmGXyGddTzog/SY4eV6zMk/09a8kA0S/94Z1UQQlydo=;
 b=Ypzv456ELx9gF6epBFEr/1/m3a+fsznyt6EdQwcNLgZwJ5bXN+TZ3FwfJgreBK6zRXXkDDcn6Fl2nk2K9NBMb+asCtmF2DqOkNuuk0FU7YqyBeXjm26wMY5W0FPP3jMHjhJC0WD/008DuGOQq6zPDsbDynSoB4x8/SPaT0jLbj8q9vuhXs0xgWQn29NOY4GpSqCSTPJejK8Pxk77SHTL6pEkhhMI7ns5FezLXjxBGP8H9TEIrSrbIzPe/zXEozQmUdsSogxqzop/RPJa8R827dJknlITFkjB4zsac3+QiZGpVdj/RuXfM8+/uNcbuDiAt6fxSUNLWKKupaR/38OG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmGXyGddTzog/SY4eV6zMk/09a8kA0S/94Z1UQQlydo=;
 b=HXAIPzUPVX4xUAGobBVChBBtlFN/nebdpum56vWCvXCR/BxJXT92uRiToH3JbpcoTl+te+ttSKSk5eTa9xVwavH+YUMqsaYwlnd11SBtCpAiglXdAIVQvIXgy89CGf7En7I5op1hSNZTrGX4kysRcr5/KFYKaPUPCC1p4bXt5Fw=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN4PR2101MB0813.namprd21.prod.outlook.com
 (2603:10b6:803:4e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.1; Fri, 22 May
 2020 16:40:16 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::e954:af85:b4a6:a718%8]) with mapi id 15.20.3045.007; Fri, 22 May 2020
 16:40:16 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/Hyper-V: Support for free page
 reporting
Thread-Index: AdYuDAEiPLOc+vnoR1KnBaBInLPPAQAeU/0AAHOA1cA=
Date:   Fri, 22 May 2020 16:40:15 +0000
Message-ID: <SN4PR2101MB08804F99992085C64982C821C0B40@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880BB5C9780A854B2609992C0B90@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20200520090158.4x4lkbssm7ncirn7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
In-Reply-To: <20200520090158.4x4lkbssm7ncirn7@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c8ca:a51:eff4:4aba]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3366da3-becf-49c2-4852-08d7fe6ece99
x-ms-traffictypediagnostic: SN4PR2101MB0813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB081353C80AD3736BF6A0AC6BC0B40@SN4PR2101MB0813.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZenRM6DrUtu43V/ilsdjHv/k/kyZY0iTQsd1j1w77EgDBXZPioiVv7oBARSNuJp9PhGEo5oxPEh5aeg4YDN7K65ZHtK2AYnDBOGgc2YyzDB6hDaKOHfICQrl7Q9np+JaUglyD2lCTW/Dy4rLhfR93gTtLWl47lbG2savsOJGuxqqB6m0QHq5EP+UikYhycW8Qpwkh34iNOBO2SvkNArbaKhlr/kXKN0bmLMtTispQpnfISBgLgqo1wB4wOBg10qZoMxzsf3qhTiKfMOclCjFbr9HLtUGXwZlENXnuwUpTFfgzyM12apCKQCwKxAaqWeeh4U8p0DL+Z4VVcXoCvQsNQAOjXNOSqJFd3TpVJ59KspfRjisaDTabZYIklWvW6R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(8936002)(5660300002)(86362001)(76116006)(66446008)(66476007)(66556008)(64756008)(2906002)(66946007)(316002)(478600001)(82950400001)(71200400001)(82960400001)(8990500004)(10290500003)(8676002)(52536014)(110136005)(6506007)(9686003)(55016002)(186003)(7696005)(54906003)(33656002)(4326008)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /3v57N/8fVLkyoM+j4AM0rKZH2N58QlWKqf4FGEG5mywh0qt7n9H99cyrfUpPmRMgGZBwxA6E2LFLiQ/ahgS4WcIrFm4pZF7eDu2wzsGNj8OwVbqfw+FM/ooaLaR7PaEkOZLz3KqkdBGeAIn0ftruFU8ndMCmnmUez0XyXLdMWv8xl00N0PlEbBWFzydPWa7AurSQcDYJaH91IuCfFWOXYPoawWXDmvpNvwP2Yky/PeeZn5p6rZgm97jUrU2djlGosZRr6G25QaOYVTZef0+rcDxOP/U4MvtzKqVcoNMalE3nwGpDqGOlTFVX9wIOa0RSJ2j01q1kqtuFFDT5H+ficsp0F6tBb+kOua/SVLe+3xF2RRlhnJsxnejPSncLgni5iWcapPOwg0ih1mwTp39IXvzHy4y0YGg6N2xn1lBlaRJ9aktdoVYYIfKXb1x3pQVP+e21N6Wj/CVP5Kr2bOh6GKtFwMzo1rK+/WRko1899U3yu/n0weqSiOQuYRxFSI0WRWWt0GL1u93BwITKCo7qkYX7rfw+Q555wFysq3RpvM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3366da3-becf-49c2-4852-08d7fe6ece99
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 16:40:16.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBWO7d9tkVVe0N4FCNojO+gNHRNxdPCKpfgLmql75m/yelCnEG8lBJA5/6ZPmSHax2acvdKac6NqOsSUFUBurMvxB+zs6R2bcGkIgnNEVpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0813
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +	if (hv_do_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES, NULL, cap) =3D=3D
> > +	    HV_STATUS_SUCCESS)
>=20
> You're using the input page as the output parameter. Ideally we should
> introduce hyperv_pcpu_output_arg page, but that would waste one page per
> cpu just for this one call.
>=20
> So for now I think this setup is fine, but I would like to add the
> following comment.
>=20
>     /*
>      * Repurpose the input_arg page to accept output from Hyper-V for
>      * now because this is the only call that needs output from the
>      * hypervisor. It should be fixed properly by introducing an
>      * output_arg page once we have more places that require output.
>      */

Sounds good. Will add it in v2.

> > +#ifdef CONFIG_PAGE_REPORTING
> > +static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_=
info,
> > +		    struct scatterlist *sgl, unsigned int nents)
> > +{
> > +	unsigned long flags;
> > +	struct hv_memory_hint *hint;
> > +	int i;
> > +	u64 status;
> > +	struct scatterlist *sg;
> > +
> > +	WARN_ON(nents > HV_MAX_GPA_PAGE_RANGES);
>=20
> Should we return -ENOSPC here?

This is more of an assert because PAGE_REPORTING_CAPACITY is set to 32 and =
has
already been checked that it is < HV_MAX_GPA_PAGE_RANGES in enable_page_rep=
orting.

> > +	hint->type =3D HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> > +	hint->reserved =3D 0;
> > +	for (i =3D 0, sg =3D sgl; sg; sg =3D sg_next(sg), i++) {
> > +		int order;
> > +		union hv_gpa_page_range *range;
> > +
>=20
> Unfortunately I can't find the semantics of this hypercall in TLFS 6, so
> I have a few questions here.

This structure is not specific to this hypercall.

>=20
> > +		order =3D get_order(sg->length);
> > +		range =3D &hint->ranges[i];
> > +		range->address_space =3D 0;
>=20
> I guess this means all address spaces?

'address_space' is being used here just as a zero initializer for the union=
. I think the use
of 'address_space' in the definition of hv_gpa_page_range is not appropriat=
e. This struct is
defined in the TLFS 6.0 with the same name, if you want to look it up.

>=20
> > +		range->page.largepage =3D 1;
>=20
> What effect does this have? What if the page is a 4k page?

Page reporting infrastructure doesn't report 4k pages today, but only huge =
pages (see=20
PAGE_REPORTING_MIN_ORDER in page_reporting.h). Additionally, the Hyper-V hy=
pervisor
only supports reporting of 2M pages and above. The current code assumes tha=
t the minimum
order will be 9 i.e 2M pages and above.
If we feel that this could change in the future, or an implementation detai=
l that should be
protected against, I can add some checks in hv_balloon.c. But, in that case=
, the ballon driver
should be able to query the page reporting min order somehow, which it is c=
urrently, since it is
private.
Alexander, do you have any suggestions or feedback here?

>=20
> > +		range->page.additional_pages =3D (1ull << (order - 9)) - 1;
>=20
> What is 9 here? Is there a macro name *ORDER that you can use?

It is to determine the count of 2M pages. I will define a macro.

>=20
> Wei.
