Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B9E2CC73E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgLBTxx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 14:53:53 -0500
Received: from mail-dm6nam12on2112.outbound.protection.outlook.com ([40.107.243.112]:28865
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389461AbgLBTxw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 14:53:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyDShpub7Fo1Nf1kpUl4mk3dC0oYbV+xv6l2VFH2l2TvjQ43D5LrkL1ArcScu5eTyLP5WHszJJGb9UXwACgSU1mf01VHHSYimhGIYp9pAUBdJm61UhePDVRx8Rh+6SW7nGCAlCH184DSPi7ry4/7/5AFnc/GAOTUNY+qhTreNEg7SYj3paT99sDFxvnJo2rzewKpHU/v3t8UCJY+8VgCYCU111YzEMxxXTPaNciqdrl19xjSXVtlBNP1DvXJEXOGnFxXEk5OuRwfoMV3v9T9r5hc0wppI9qt/rpELUb/L2DDAPShpY1nKjCertGORuEXKDGVSLWqfzcS12ezG46lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFD/Mhmm1G5KOwxwxyFlnLamxvpImAnKCcktl6A0i0g=;
 b=TuPNB+CyTECFZhfJRjVLZ02wEfFhpnJXNRM+h9T5wkIlM/I/Dp6lILuiBJSpys683NtG0oNpKlFfj6IKymWUZOpM3hAO10SctJS4j1GYpvfpvqhFyVi9kPK8e6dsW4wfuvKhncsCwGTLNBNCFdUocubIBRgX+PUlA6o+rmQzbobB2Daegtqpt7Fk44I/JXJHKvbFHKoXUxSR2GhcqDiguZN6OvFKs3uK5bEHWZ6yjIKUg0Vhrbl5nMaK6J22dZBgY1fOh5FXeX131CbI//e6htvUCG6p0zs5S0pjgAj1A9mkO3dCGyziEiWo4GmEtPPAFluzvWlROSAvRYuUKBu7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFD/Mhmm1G5KOwxwxyFlnLamxvpImAnKCcktl6A0i0g=;
 b=M2dYDsJagSRVSaHkL0aijn5FH7kcsDoTia5tGh/OVir4Dm8q74SARUic6vtxk6AA6itjLidxl0VJ54/kgJ7HpeA3dOUtWViSiCKov4RdRQgFoerod+Urb0ehTRTrLbIX5NOG+FE6SjqDX3VeTnpJdX8VYnyqhi2aZP2bDtV5u6s=
Received: from (2603:10b6:300:77::17) by
 MW4PR21MB1924.namprd21.prod.outlook.com (2603:10b6:303:7e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.2; Wed, 2 Dec 2020 19:53:04 +0000
Received: from MWHPR21MB0863.namprd21.prod.outlook.com
 ([fe80::9de4:6549:6890:b7ba]) by MWHPR21MB0863.namprd21.prod.outlook.com
 ([fe80::9de4:6549:6890:b7ba%5]) with mapi id 15.20.3654.002; Wed, 2 Dec 2020
 19:53:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit
 APIC ID support
Thread-Topic: [PATCH] iommu/hyper-v: Fix panic on a host without the 15-bit
 APIC ID support
Thread-Index: AQHWyJFnhI2DigaJq0ylxsLVtcyCgankN98w
Date:   Wed, 2 Dec 2020 19:53:03 +0000
Message-ID: <MWHPR21MB0863B35957EE6D2869B379ACBFF31@MWHPR21MB0863.namprd21.prod.outlook.com>
References: <20201202004510.1818-1-decui@microsoft.com>
 <87wny0edko.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87wny0edko.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fba6cec8-7120-4ab7-ab29-04123cb4a7bf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-02T19:51:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:50f3:6377:2ff1:3ac2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bba54fee-ab03-4da7-69fc-08d896fbe1c1
x-ms-traffictypediagnostic: MW4PR21MB1924:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB1924E5C96A249EF87FE78D69BFF31@MW4PR21MB1924.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qm+XNVR5Y1io9f3pF5vZS7Q+ZRgKLqXx32Uw6mhikSKZ3MeE7vtsddiaOQLQfgQ6VDzkXrQHUvj+Cu8u7DVm5Ur7rXPzeIsOZCHzLeCLZBV5mc9ySmvnOjWdHTs/8MatRp7cbuBi+frTt7D1FcnI+oVQD9giU+FSy8Y0iHhSgO3KLB0PsI0SOv/+pfedd6+JrJo2EZAet2Tg2jZ5AVHDMpNJT2kZ2MBBwy9IHKMhYtrMIoGOW/80715BuUb/oWkQ8dNZqkWQw9wnk9c7K86VVQ08SQkgXoHgPUHrXPmzZ3ERycCUWZrLhwhYKDW7aMnEIm7KN02/qImqgMMhploSaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB0863.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(186003)(54906003)(110136005)(478600001)(82960400001)(316002)(82950400001)(33656002)(5660300002)(4326008)(10290500003)(8676002)(6506007)(66946007)(7696005)(52536014)(66446008)(8990500004)(76116006)(86362001)(66476007)(66556008)(64756008)(8936002)(55016002)(2906002)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VtephnWGOBvGt0hYaBuSkMKe7Oiz0YCEBesabIWFUeFWMqKqxLHt4Lrjead+?=
 =?us-ascii?Q?Jb1DoxBTnk4Canp1DDACs8BjObWgitU5SXkUJs5yAwBxHpOxpw3RkxOX4DP5?=
 =?us-ascii?Q?Uvk3Ab3gMDD1ilrykTe0hTbDSrbGBs0w+tl+0aLkv/P8dtUXQ8eksyaoXcE3?=
 =?us-ascii?Q?iQnAO8VXeNjOkEHjD6MWFRKsQyLVMTmewvZSYKCGSTSDyDDb5VbI/lsk8bWe?=
 =?us-ascii?Q?jdAxEPF6GLXXb7MrO7ybQpTJwm9juFee8pf2ShJS5MsLfgpL3C8iXrL2YtAo?=
 =?us-ascii?Q?Ko/JNT9cwku6BPdUDyHOMa8ZEAKsSV1wMc0efs2G4TtVu4dYftMWiZs4cBAX?=
 =?us-ascii?Q?94OSpkRwBFwrk2Vnj3vMfewaKmG5gOGbpubjSe1Jx0D1tPDetW0UHEsW80GS?=
 =?us-ascii?Q?05gJBA5bG2YOIdS87+29FQRGb3UHnQuxO8QdDKa9Py/kYRknCQaUYC463Ash?=
 =?us-ascii?Q?2ypGNgWT8UaO1C3iOVuREYa1mhtmuCqljzxdmp3ERUWEewkWHcSJxXJhbZeA?=
 =?us-ascii?Q?ju28o/oQM8XkhtOtlLLBMCR0HkJN3Fh7OCB2ImwtqkXmS5J7HvZKt2Dz8KNi?=
 =?us-ascii?Q?zZbP6/0dxsfK7O6JcS2Urx6y2T87tqyNJ3JwAUuHH3jF44ST2Z3yXPVD7fmF?=
 =?us-ascii?Q?TL9bPdOI38iGQkjgbaKI4nDrn3EnfrDZ/CdOSAAYA3hdOGx+kOa9V0ZZqBpo?=
 =?us-ascii?Q?UFbnNzs4Ij6gb+fqckSGiYf20zFs3kdy13MolksJ4d9KBdo7JtngzAjYXO/g?=
 =?us-ascii?Q?taP1Ae5NFHkoP6LwNaoVfTZogMWbRsGszyHBaCRgV6bUf38DzIj7DKzz3+1f?=
 =?us-ascii?Q?xaqS1ISIjrFawvlb7nCFuq1XST4F9QzjgSKww1KgkTk3zcnJeUDnQ5XICFKU?=
 =?us-ascii?Q?nlKTYz2rjba5ChvHz1haj8ivzGBWQlYa9cMDTry4qkRzmJm5c0jJ/EdeF71n?=
 =?us-ascii?Q?gnrgUqE/R+dPNqGcwsPUxhi0rp2CwbRtPcv0vi5iXTYqkL3QIn8t71COusxZ?=
 =?us-ascii?Q?jbAnzknKTS/nsrY6eD7Dys46RZR7gAziyL6eDLjtvZQbbBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB0863.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba54fee-ab03-4da7-69fc-08d896fbe1c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 19:53:03.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQcPQikcgjiPRbq2F31//MCSSknmVUyE6Voke6gh8GsIQDF3bF2oYRpYVYbqvmDLagDMHVzxRwlzuETxzD8TDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1924
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, December 2, 2020 1:56 AM
>=20
> On Tue, Dec 01 2020 at 16:45, Dexuan Cui wrote:
> > The commit f36a74b9345a itself is good, but it causes a panic in a
> > Linux VM that runs on a Hyper-V host that doesn't have the 15-bit
> > Extended APIC ID support:
> >     kernel BUG at arch/x86/kernel/apic/io_apic.c:2408!
>=20
> This has nothing to do with the 15bit APIC ID support, really.
>=20
> The point is that the select() function only matches when I/O APIC ID is
> 0, which is not guaranteed. That's independent of the 15bit extended
> APIC ID feature. But the I/O-APIC ID is irrelevant on hyperv because
> there is only one.
>=20
> > This happens because the Hyper-V ioapic_ir_domain (which is defined in
> > drivers/iommu/hyperv-iommu.c) can not be found. Fix the panic by
> > properly claiming the only I/O APIC emulated by Hyper-V.
>=20
> We don't fix a panic. We fix a bug in the code :)
>=20
> I'll amend the changelog.
>=20
> Thanks,
>=20
>         tglx

Thank you for reworking the commit log, tglx!

Dexuan
