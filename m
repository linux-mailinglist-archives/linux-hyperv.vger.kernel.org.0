Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223313D0780
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jul 2021 06:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhGUDaE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 23:30:04 -0400
Received: from mail-mw2nam12on2134.outbound.protection.outlook.com ([40.107.244.134]:8098
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231363AbhGUDaE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 23:30:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrj8OlwYgXN1QvOPuA8srr/O8Mw2JmHWYPG5qp87T025m9bkJRjhEIIfgVvM1csrgdXdQglTD9png/VRa9iIPrnr691RjlX9ttVjbPFNxnv6HCdH9QU3b7lhS96bcZbbkBrpn8hXVmlmEArBrQxjwlQHNwe7y24uezQFvUuUiq3BMOov8oPTRrTJvxG9kEHOlGFBexb/vYnqi+Ni1IpsZ7QpKDXW5aDSP5wDS62xowZ8VgcV9RGR6fRbCFXlgJPtcxa2vZfV0RDKZYFfepf0DF9SgefISUkqxBE7smQiKTnpdLkOqqQqUH/54wMTNNyi/dQQ1JAekQ0TI1Dtzr70IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG8VD8VTH6xWqYFd7xnOJcqjvPUo0C3c/zJwZGcsVOI=;
 b=fnsR0uunso7S6V4JVMFK3IDa2Vo0vNqZoQuWDHiSXKeJoffML5Qa7BBIvOs920P54JRNQT7vQa3NUGL5sHm7aa16INk6SUPU+uNlL5QCu3cQU740DVbqQACyIbUCD4gxUaNuJlof2vs7RvoKMf2RYU1e4ul0TvjqxrzEuigaqVNFuHJs5nzH1+2gSdhxqfXOP0kqCBOKzl6WHUK857UpVx+AOfsRutqwsbv9yAFiYQ1/L483YJ+1ojb4kLWfmE7NhEt7HJx86Bv+/4444JhW+TXxNPNRl8dA9jQceIkfoZPEn3CnnoqIuHoNFhSEbvPBjQx6Qxld13WCeeArjmPUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YG8VD8VTH6xWqYFd7xnOJcqjvPUo0C3c/zJwZGcsVOI=;
 b=TUjRgJp6YA9agVoEYZJxYUHGUcMpuLPfyk0IMckc2q8ZeaAzfLgiN7gfscJQ20jjHOpiEOjMnIxkXL3LEqmJmclhHuYx1wNs0EA2Yoe6hx8AiCevIfh0d6BNSmaqUbVKSYoHN8kOOovzv3AqGORScgFq5jGA4o7jgde39xvZKks=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1987.namprd21.prod.outlook.com (2603:10b6:303:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.2; Wed, 21 Jul
 2021 04:10:33 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Wed, 21 Jul 2021
 04:10:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Index: AQHXfOKuCkOiUQ46GkaTOSxdT1kTAKtLuKKAgAAjIwCAAAKZAIAALFMggAAEVYCAAMG8YA==
Date:   Wed, 21 Jul 2021 04:10:33 +0000
Message-ID: <MWHPR21MB159302588AD32CA605192398D7E39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210719185126.3740-1-kumarpraveen@linux.microsoft.com>
 <20210720112011.7nxhiy6iyz4gz3j5@liuwe-devbox-debian-v2>
 <fd70c8e5-f58c-640b-30b7-70c4e4a4861a@linux.microsoft.com>
 <20210720133514.lurmus2lgffcldnq@liuwe-devbox-debian-v2>
 <MWHPR21MB15938E4E72E1A3EB3744AD53D7E29@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
In-Reply-To: <20210720162923.rsbl24v5lujbiddj@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=733849db-e03c-49fa-bf60-1fc5317282fb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-21T04:02:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87922433-d9b4-4411-2393-08d94bfd7c60
x-ms-traffictypediagnostic: MW4PR21MB1987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB198788CA85F11644FAAA1979D7E39@MW4PR21MB1987.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MJ2ztjxgPkkNaNSmXblAjmCfKTICM2wgplEjp1z9xbbISdDZce7M2V1V9judOHryBss/hvEl0JVMlSJ3ATrUYLVnXz//vqzWoZgXdJW8gE4XmCY85ooY0sdf5kw+nN396eQCbFm4NpYe+G1bPaVr4S/2C/0hu3jgVufNFcrK+l4H9TwmBF6g3hdDwYqdzFkPY3EKo/LB1ROc6paI4rHDALkY/WGi99oh8C+bU5rP8D8ht2X1Xil56B2UwN24ahSuM6YSmTM79ew+m9zmuVxhk/Q9lc0sXgDUDBacNvA//8ePKBwuQ6mSSH8hx3ToCnoA+ccUPiFl3ay/xKrSiq4F83QKpJDEu03JV8X9tqxpt3wwIQUSfynpOoshbVKWMF19e7FVf/wxKyYyo8B6jHDz9mOjxl1QgK+xMXAcyNDeQoAaV4xt5K7kbTddwLOadqK2RcR3eUqffAnwZU61HfSa9kQ4PqEz1exGpvFAbA/y9ByNxZH0Ly5HVuU0SyQspg+bqhOyyCJP+BFyxWk1YgOEKfImVYtXXL341Jo0GT0b1qF9wBc5Nf/ejTIuNNgO3k71E5A5Wo61Kw7bRhzGIRfoUksn+ffkkivEW6+4Nl1NnsJNI6M5y7xraS9gzzp8MxOxyQ0XzKoJcek4maKMZHM3ktuDi/CDBowaIkadnOiqDLFEMhTQqCptrp1UfdCkwuDn3rH9v6G1ZWi2+GXN6Tcxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(8676002)(55016002)(508600001)(107886003)(316002)(9686003)(66946007)(10290500003)(33656002)(86362001)(52536014)(6506007)(186003)(26005)(66446008)(4326008)(8936002)(66556008)(82960400001)(76116006)(2906002)(83380400001)(66476007)(64756008)(38100700002)(82950400001)(54906003)(5660300002)(71200400001)(8990500004)(7696005)(122000001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kb10n5gswHII8s1SEx3zCC/y3bHdi1qwtCRMXauz9b5PeBfnsW9sirVen1K6?=
 =?us-ascii?Q?iKGRzmSVU2NlDgefQRv7rlocfd0D/0/MaK7bneFffkZLeVV5qDUJcZG7SGbb?=
 =?us-ascii?Q?y3nyz4sj5mkhddLig80eOhbT0LQxqf6haEQz9R0g3lkEGH1LedZEDsl4TfCd?=
 =?us-ascii?Q?4Cq2oTBl5UH8jkJ1X31hiO7Va6+vnkNKeIUuBXzM7q3QvRUrsL+q60naIU2N?=
 =?us-ascii?Q?/G2BhZkfG6jsIOKvMRLDBOARHv5MpGCF22eo0b0caHIZhAW5DgrMGoTRZ+nq?=
 =?us-ascii?Q?cny3LWet1Os9y0u/sFrIUJJEBOe6yHDh+lJzML1/3WFm9NLiNDfZYbYQfjAN?=
 =?us-ascii?Q?0z3Kb6G9/jvBV0dLaGMd4nyhcd5/k5l/Y3m22S5sr916SoUXYODVAfLeYPaO?=
 =?us-ascii?Q?8ThmPbvtdwN7eoPK7VU9h62w5ycVTCnZDa4eT6QjcibnmX+V+yV7rKY+4fSz?=
 =?us-ascii?Q?XhtbqZZMzzlF0akx53q9v6wCOAsrh2/GMpLVcvMC4uENOlnEltqV2kazS1M6?=
 =?us-ascii?Q?NIxQ9sB1/vJr6ielDSwP1Da5TkRRudbw8M2Lyl7i+YtM4dqD4F4nuD6p4H8w?=
 =?us-ascii?Q?/7XXqE9qwkRJgOasV8ZCQKcIqzz59TDvwsgUioZOoL5FkN2m6vtvaFsCNL6b?=
 =?us-ascii?Q?HjkDfWY85X4Ooax2JL17tHRcg6Y47K3rse/NWTYGdYkBcmrG9Zxk+r7VNt8e?=
 =?us-ascii?Q?si5sHQ7Yv0F8nadG4spfitmQT+HoeGTaTy58YDJ5FPmC6M64H8Rr8r+t0tkc?=
 =?us-ascii?Q?j0pvsxHNNo+jT0jaz62kH0Aw9cVFlJRZlVNAgp28BWUh2qRrzIf7VMX7dwsS?=
 =?us-ascii?Q?KmTrnSH1aq4V1USWUJcuGRjGqN1CeweVrNr7C/AIATQ9ovrE0zLWV3d6rXvr?=
 =?us-ascii?Q?lvpMoEM2AH3xPPFbOEkFs6kUywRVw0NcT3/SGSz2Z29yF4kQPRxkoEuAEfuZ?=
 =?us-ascii?Q?6y6Cy8evkWswSrcTh+fTEXTPz4KOO0qES95+iPAhl66njDLpc/RkS5KZTLDk?=
 =?us-ascii?Q?/LhTZus1tWVxL2tcQBfLZaA8DPoNBHrSltR/B1v70QGteRHsFjVR/qdCNdDe?=
 =?us-ascii?Q?qsQT9F4iC6c9QTxNYdJgTBdsJxAPlxU2ssr3v06DiBtiMSskSiuEqN8SC+o+?=
 =?us-ascii?Q?1PJpMsj8gCARHdiQOt9NJzaMNzCUdroIMq8YzcxwcpMo/hZuQmjDXNAe+G9L?=
 =?us-ascii?Q?ZEyfEw7a1FJgAYsyFxHajUrLSzDxgz8wsh1otn8bTUaK+dn1XPzfU0borehy?=
 =?us-ascii?Q?Rs0gfi53qCq3/t0b1G4OMmCUZ7Qj7af774wNup5AShXLFYtN7QJF7sA/6Pu3?=
 =?us-ascii?Q?Hav10QGOJq8A8ahR8BxC7/85?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87922433-d9b4-4411-2393-08d94bfd7c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 04:10:33.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nilfdhRSyl8T5UDbiq9QDsWPvftLp/XAWKHvNU1xJa2Tnv3CPFoazV+aCHMQzXgaCzds1kuZ8Z1j+U2rMlBL9UfFTd/vpwSQ3+lsmVfPcT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1987
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 9:29 AM
>=20
> On Tue, Jul 20, 2021 at 04:20:44PM +0000, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 20, 2021 6:35 AM
> > >
> > > On Tue, Jul 20, 2021 at 06:55:56PM +0530, Praveen Kumar wrote:
> > > [...]
> > > > >
> > > > >> +	if (hv_root_partition &&
> > > > >> +	    ms_hyperv.features & HV_MSR_APIC_ACCESS_AVAILABLE) {
> > > > >
> > > > > Is HV_MSR_APIC_ACCESS_AVAILABLE a root only flag? Shouldn't non-r=
oot
> > > > > kernel check this too?
> > > >
> > > > Yes, you are right. Will update this in v2. thanks.
> > >
> > > Please split adding this check to its own patch.
> > >
> > > Ideally one patch only does one thing.
> > >
> > > Wei.
> > >
> >
> > I was just looking around in the Hyper-V TLFS, and I didn't see
> > anywhere that the ability to set up a VP Assist page is dependent
> > on HV_MSR_APIC_ACCESS_AVAILABLE.  Or did I just miss it?
>=20
> The feature bit Praveen used is wrong and should be fixed.
>=20
> Per internal discussion this is gated by the AccessIntrCtrlRegs bit.
>=20
> Wei.
>=20

The AccessIntrCtrlRegs bit *is* HV_MSR_APIC_ACCESS_AVAILABLE.
Both are defined as bit 4 of the Partition Privilege flags.  :-)   I don't
know why the names don't line up.   Even so, it's not clear to me that
AccessIntrCtrlRegs has any bearing on the VP Assist page.  I see this
description of AccessIntrCtrlRegs:

The partition has access to the synthetic MSRs associated with the
APIC (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR).
If this flag is cleared, accesses to these MSRs results in a #GP fault if
the MSR intercept is not installed.

But maybe you have additional info that applies to the root
partition that is not in the TLFS.

Michael
