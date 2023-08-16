Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2477D89E
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 04:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbjHPCyp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 22:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbjHPCye (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 22:54:34 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C3C212B;
        Tue, 15 Aug 2023 19:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8wTHJDfVr42Kdj7IHQDPysHopScT3/WC6nJVjEcjIfxzirYZExUBENmIY/ZwLgerhU+gcFicPXlLY4BahMoZO1wdcN8W1BMdQMLVQMl5fAZI/Oyru52km9Sr9ZWtImnxsXsWZE2M1ijk9l2LttAILruBYq6etgwdaZiyV6FTlNgAV5E0Mn2qCCu03anJVwIWHzdfmGEaP2XFPLgAZRfR4JwvQadDHv44+OG54VjTISU0fI9DGrGfzxZqq3F5Zi3/5zV6Czlge5yHGQPGChtQ+50fHV7UDVbb/iNQCIFm0EEOD7EwpxiS5a3byq9b2VidYaXrSs5y2wxZeSEKlsaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBi+ke2zPjoVfa28gVfv0ctHRhxQrNSj5PeZOGXeIec=;
 b=Ha62rkp0wzO+rYdv75t9YB65Gh14JqJnFvBbj/hS1nIf8XPexQcUBxwb4ErEabmlm24DpNdqnVGfHsPj6/MGMAeYetI+ConzViBzSblUp4kmQhBqZdGR80yEnsSbhcvysTWamQPwlKSiV220iD+ZeLdzvrW2X06+rTsP9TEhXLRy+u/qBosVN4l3wCf1M+Or6fdR8+mmYARcG5oRcuJPRMAItQepvcQFFMzzdW0kWUWRtoAy+/m9I9kAyTu3+o3SxfoQXEqXTsLiJbXSv4I83dulg5IeUZXM4S3VGaypetJSFQT37Umxmvk8ciyB8yI2dAS8H3n7czC2+DhQ4pXfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBi+ke2zPjoVfa28gVfv0ctHRhxQrNSj5PeZOGXeIec=;
 b=dyc+fKDdvJmn71iM/k4JSvvO/Bt39uvNRI5qJpdV/nIg53uxweoNYjoSfhk13Cf+l8TCilDbMBfIEpzekffEx7IjuI623LrZoBHSoCzsx1JCae8wZl3kgcEIRyTmlVoZXNsG6d+vgMfnN1pQj7l25Y9qr/FAEm4MrhZVxbcSaBA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1465.namprd21.prod.outlook.com (2603:10b6:5:255::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 02:54:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Wed, 16 Aug 2023
 02:54:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nq/eB+iAgA5qfIA=
Date:   Wed, 16 Aug 2023 02:54:29 +0000
Message-ID: <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
In-Reply-To: <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec984448-4b40-4599-8738-7909b838a118;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T02:28:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1465:EE_
x-ms-office365-filtering-correlation-id: c740c2ac-7437-4e89-f015-08db9e041c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmDKlNbS/mnc6rvVb0Um+qhQcdDuRa5nTo8GrBsyl5jGo22ZjXxOwct2xPaBlBbSJ0732D5oJcYRvVcvoBZJKz7sgJke2jIZ9mP0zfstWxBDSCyHCvkHOaf1c1F6xFM5O57T8Rjj/oYV7y6uI/JTIXkabZZQBAQB6HxXxluU8AWqb+woOF7olUcxJ/Dj8w4wNbS6jQtAn0strgnJ7nExlJS2+0hCyTDDC5ueP4WM/QGvnfTOQcPo9Oa4VtVbwdIfB2QNy6c6lKxFBjCup/OE9dOucNOsCpfKbIcU7zDxZmACf3i/oJqIM8Np3615cFZMqRClo6qp+7KIqtrDrTJrJun4wYkWdLd+3TOTCZB9ETKfRfhAdH62C9otMkVtr5gQOYg6EC84QtU3a2jUiFmRSE1bQvYZ1jKZcAH7WUAlGXbUFYhstkBaQJPRPu5rDIGApExAVxuQ4kjRvqccGnr9bikOW6swCCNAD+zzFteq2+2MvWAMRTlT+advHgQMIAOKYUfGadhm3/n0DWkBlNdAo+ROf0qVeOk0CTcoRXyuW6HHNCa385aqNLkt5xYzZ7258c3fnybHLhWIlpkl1Fc3inGYMCSRj4d0o19oE/98W8GrT+KAz8u4kJjoOOEi374qk22jijONwY7LUKKYCrYVV5IQb9TYzOvjo4ESeyIOP2G/Hq6D8SujQbRfvi13RcdCKFaYSTBKaAr5lwgE8tdV/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(376002)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(12101799020)(6916009)(122000001)(4326008)(38100700002)(316002)(82960400001)(41300700001)(5660300002)(55016003)(82950400001)(71200400001)(66946007)(8990500004)(33656002)(66476007)(76116006)(66556008)(478600001)(64756008)(66446008)(86362001)(8936002)(2906002)(52536014)(7416002)(38070700005)(8676002)(30864003)(7696005)(6506007)(9686003)(10290500003)(26005)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5RlMy2GMLBUSEB/7gXa4tp5NRvPwdIufrmo70TpDsvZ70pf6JRv5TqUKIf1D?=
 =?us-ascii?Q?TnnBmSIqz/hW87PT0Odf7lAx6JKBDzdUdi0TKyWqabmI0KMeCf6rQqdeG39h?=
 =?us-ascii?Q?yeLGH7rJ2SDVAPSS0SnlrTx8EJeN2q7QIvratWE8Pt+nqM5faitQCy7voESA?=
 =?us-ascii?Q?lRU6169/GEe6CM6R2ACAk3Ro/Z7e8qw4nXeyDEIRslh1M/Zk0T9HGCkJRmlY?=
 =?us-ascii?Q?yhbV5e5zSziykFi/s8AjXGkLtO4tvvmyFesZaBWpi/iPGWQW795DSSfvdygf?=
 =?us-ascii?Q?0HsOZR4bJurjOK2UVmTekt+84xeaZDZ860NeySQsHXJcdTPahJXfPf2f8TKS?=
 =?us-ascii?Q?zvTZ8llpk6uMzlBd+GUYeKNfGO35nNQ1HVTFLORfetyBACE2Lj4h7BZvp0x4?=
 =?us-ascii?Q?q2/kV7bAJFRvPjCrB2csNwTVzwW2S5xN8LZ8L+hyR1fZXVMeuSFQZi0IrUDm?=
 =?us-ascii?Q?4/Yo/ujlTI/IRnDAQIlIfYnyfmdrrXzT8bOLa8eB7GRcjhWhhFy9maoJGmh8?=
 =?us-ascii?Q?V32DrQLr5vuJ/UhLqmgucgh7Xxoiyzuj8S8SuoGUsBfxpC3hvAtzi+zU/QYA?=
 =?us-ascii?Q?OZt5LvC2F5tHSZgwje4QtTRZxjHiRChTSVTwzHwqWD4WYujqkp54Txe0yrTV?=
 =?us-ascii?Q?3oqJ7BiU7SWe1kq/TW5L5tLMbor+EJDzO6td56oFPqTAeFlktd3hvygjTG2S?=
 =?us-ascii?Q?HLLUPRp57MkaPTQJqO0Or3V77R1N7j83/d6YpD+mcDPUBIy3Og6XbmkKWEi8?=
 =?us-ascii?Q?BjDMCuH91hZ9h8gFD1BjcJ17vOgTljEHP5fXI3ncSEJhRjhGKSIP6PGQ6HXj?=
 =?us-ascii?Q?TXF9IBvJaKu2DVOBB4P3jXzu3KisiD4HJlHBwRPP4GrAN87O1UsZ+6ElJru6?=
 =?us-ascii?Q?AwzgA/Qa4uCW2TQooayzEjAhO9S0+2cpwd1/ChHPug6tIZH2DsQRYPPC1Y1H?=
 =?us-ascii?Q?Py2ZtQNkxuGa0m+N2FpbLW6CQQoPvOLGJlTnm17/nbtBjG2qHA4Iz91CGGAM?=
 =?us-ascii?Q?lyR2XaIt6wVV5k5McbHmMbFhsWR/U/QOC8/tmMq5M2AUwS76Ble9XrUzZJYG?=
 =?us-ascii?Q?4OckjhpqRvh/nVHZFgvkNN4jM5U5ZZ94xIPU2ftIJzAR26BubQ0hCWahBqWd?=
 =?us-ascii?Q?Tmm9Od5hB2BiUKcEqVMWpSRmz0kMUOAuSO00D8KTTTn9f4MWzstYJDQclRzR?=
 =?us-ascii?Q?ZI8xyHO+WocY/NzOZQKYNp8hTA6dkEVnbFBCKOE5NNNFKZ/x7O76Ye81n9+Z?=
 =?us-ascii?Q?+t1Z6hN2kpYSiszgpOVetSiqtOm77/0qCY4SomxqeZ2CiQM7rp9hTgnRXJNP?=
 =?us-ascii?Q?MOZ2EB/gFl/93G7MQnPBSilyLz5HPWzorxwx3kkKYD51lh7jCm6XCwwgQ0VC?=
 =?us-ascii?Q?7AyUvVrd2QyrPEK+YaD0S3KTbJsolwBkPcOOMiWJL2QhGNDivRzm8c3IIxUr?=
 =?us-ascii?Q?SBdfp/GhUHJQmJSgdhoPjIjgj1X/8nhv9As4WBkCu5QJbeic21OuPOQuWjoO?=
 =?us-ascii?Q?zSXtulUZkZEuT/wzwSQV0dphdDlpcvKsdhopZSJfWnwQht4W5EEiOX3dnC2i?=
 =?us-ascii?Q?LHUbfUmwQDOsnPqsnKJ50Lt0IOreei6i8ZALvaxxdJtKZVR9LFVPSvgZU/Sb?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c740c2ac-7437-4e89-f015-08db9e041c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 02:54:29.0978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqtb190CHGtN+bCsbV1J/rbTlhl2OLL+/fzdVCycFv7MUVFf/APuL3XWn7cXh6EpmJf2S5ok+5kIBy3Lze8Yjp2FlkBopSczSJLeUwUZWr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sen=
t: Sunday, August 6, 2023 3:20 PM
>=20
> On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> > In a CoCo VM when a page transitions from private to shared, or vice
> > versa, attributes in the PTE must be updated *and* the hypervisor must
> > be notified of the change. Because there are two separate steps, there'=
s
> > a window where the settings are inconsistent.  Normally the code that
> > initiates the transition (via set_memory_decrypted() or
> > set_memory_encrypted()) ensures that the memory is not being accessed
> > during a transition, so the window of inconsistency is not a problem.
> > However, the load_unaligned_zeropad() function can read arbitrary memor=
y
> > pages at arbitrary times, which could access a transitioning page durin=
g
> > the window.  In such a case, CoCo VM specific exceptions are taken
> > (depending on the CoCo architecture in use).  Current code in those
> > exception handlers recovers and does "fixup" on the result returned by
> > load_unaligned_zeropad().  Unfortunately, this exception handling and
> > fixup code is tricky and somewhat fragile.  At the moment, it is
> > broken for both TDX and SEV-SNP.
>=20

Thanks for looking at this.  I'm finally catching up after being out on
vacation for a week.

> I believe it is not fixed for TDX. Is it still a problem for SEV-SNP?

I presume you meant "now fixed for TDX", which I agree with.  Tom
Lendacky has indicated that there's still a problem with SEV-SNP.   He
could fix that problem, but this approach of marking the pages
invalid obviates the need for Tom's fix.

>=20
> > There's also a problem with the current code in paravisor scenarios:
> > TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> > to be forwarded from the paravisor to the Linux guest, but there
> > are no architectural specs for how to do that.

The TD Partitioning case (and the similar SEV-SNP vTOM mode case) is
what doesn't have a solution.  To elaborate, with TD Partitioning, #VE
is sent to the containing VM, not the main Linux guest VM.  For
everything except an EPT violation, the containing VM can handle
the exception on behalf of the main Linux guest by doing the
appropriate emulation.  But for an EPT violation, the containing
VM can only terminate the guest.  It doesn't have sufficient context
to handle a "valid" #VE with EPT violation generated due to
load_unaligned_zeropad().  My proposed scheme of marking the
pages invalid avoids generating those #VEs and lets TD Partitioning
(and similarly for SEV-SNP vTOM) work as intended with a paravisor.

> >
> > To avoid these complexities of the CoCo exception handlers, change
> > the core transition code in __set_memory_enc_pgtable() to do the
> > following:
> >
> > 1.  Remove aliasing mappings
> > 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> > 3.  Flush the TLB globally
> > 4.  Flush the data cache if needed
> > 5.  Set/clear the encryption attribute as appropriate
> > 6.  Notify the hypervisor of the page status change
> > 7.  Add back the PRESENT bit
>=20
> Okay, looks safe.
>=20
> > With this approach, load_unaligned_zeropad() just takes its normal
> > page-fault-based fixup path if it touches a page that is transitioning.
> > As a result, load_unaligned_zeropad() and CoCo VM page transitioning
> > are completely decoupled.  CoCo VM page transitions can proceed
> > without needing to handle architecture-specific exceptions and fix
> > things up. This decoupling reduces the complexity due to separate
> > TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> > introduce new capabilities in future versions of the TDX and SEV-SNP
> > architectures. Paravisor scenarios work properly without needing
> > to forward exceptions.
> >
> > This approach may make __set_memory_enc_pgtable() slightly slower
> > because of touching the PTEs three times instead of just once. But
> > the run time of this function is already dominated by the hypercall
> > and the need to flush the TLB at least once and maybe twice. In any
> > case, this function is only used for CoCo VM page transitions, and
> > is already unsuitable for hot paths.
> >
> > The architecture specific callback function for notifying the
> > hypervisor typically must translate guest kernel virtual addresses
> > into guest physical addresses to pass to the hypervisor.  Because
> > the PTEs are invalid at the time of callback, the code for doing the
> > translation needs updating.  virt_to_phys() or equivalent continues
> > to work for direct map addresses.  But vmalloc addresses cannot use
> > vmalloc_to_page() because that function requires the leaf PTE to be
> > valid. Instead, slow_virt_to_phys() must be used. Both functions
> > manually walk the page table hierarchy, so performance is the same.
>=20
> Uhmm.. But why do we expected slow_virt_to_phys() to work on non-present
> page table entries? It seems accident for me that it works now. Somebody
> forgot pte_present() check.

I didn't research the history of slow_virt_to_phys(), but I'll do so.

>=20
> Generally, if present bit is clear we cannot really assume anything about
> the rest of the bits without external hints.
>=20
> This smells bad.

Maybe so.  But if we've just cleared the present bit, then we really
do know something about the rest of the bits.  We could either
document a constraint that slow_virt_to_phys() should not assume
the present bit, or write a separate but equivalent function that
doesn't assume the present bit.

>=20
> Maybe the interface has to be reworked to operate on GPAs?

I'll experiment and see what that might look like, and if it is
better than doing the page table walk after the present bit
is cleared.

>=20
>=20
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >
> > I'm assuming the TDX handling of the data cache flushing is the
> > same with this new approach, and that it doesn't need to be paired
> > with a TLB flush as in the current code.  If that's not a correct
> > assumption, let me know.

Kirill -- could you comment on the above?  I don't fully understand
the TDX scenarios that need data cache flushing.

> >
> > I've left the two hypervisor callbacks, before and after Step 5
> > above. If the PTEs are invalid, it seems like the order of Step 5
> > and Step 6 shouldn't matter, so perhaps one of the callback could
> > be dropped.  Let me know if there are reasons to do otherwise.
> >
> > It may well be possible to optimize the new implementation of
> > __set_memory_enc_pgtable(). The existing set_memory_np() and
> > set_memory_p() functions do all the right things in a very clear
> > fashion, but perhaps not as optimally as having all three PTE
> > manipulations directly in the same function. It doesn't appear
> > that optimizing the performance really matters here, but I'm open
> > to suggestions.
> >
> > I've tested this on TDX VMs and SEV-SNP + vTOM VMs.  I can also
> > test on SEV-SNP VMs without vTOM. But I'll probably need help
> > covering SEV and SEV-ES VMs.
> >
> > This RFC patch does *not* remove code that would no longer be
> > needed. If there's agreement to take this new approach, I'll
> > add patches to remove the unneeded code.
> >
> > This patch is built against linux-next20230704.
> >
> >  arch/x86/hyperv/ivm.c        |  3 ++-
> >  arch/x86/kernel/sev.c        |  2 +-
> >  arch/x86/mm/pat/set_memory.c | 32 ++++++++++++--------------------
> >  3 files changed, 15 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index 28be6df..2859ec3 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -308,7 +308,8 @@ static bool hv_vtom_set_host_visibility(unsigned lo=
ng kbuffer, int pagecount, bo
> >  		return false;
> >
> >  	for (i =3D 0, pfn =3D 0; i < pagecount; i++) {
> > -		pfn_array[pfn] =3D virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_S=
IZE);
> > +		pfn_array[pfn] =3D slow_virt_to_phys((void *)kbuffer +
> > +					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
> >  		pfn++;
> >
> >  		if (pfn =3D=3D HV_MAX_MODIFY_GPA_REP_COUNT || i =3D=3D pagecount - 1=
) {
> > diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> > index 1ee7bed..59db55e 100644
> > --- a/arch/x86/kernel/sev.c
> > +++ b/arch/x86/kernel/sev.c
> > @@ -784,7 +784,7 @@ static unsigned long __set_pages_state(struct snp_p=
sc_desc *data, unsigned long
> >  		hdr->end_entry =3D i;
> >
> >  		if (is_vmalloc_addr((void *)vaddr)) {
> > -			pfn =3D vmalloc_to_pfn((void *)vaddr);
> > +			pfn =3D slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
> >  			use_large_entry =3D false;
> >  		} else {
> >  			pfn =3D __pa(vaddr) >> PAGE_SHIFT;
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.=
c
> > index bda9f12..8a194c7 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2136,6 +2136,11 @@ static int __set_memory_enc_pgtable(unsigned lon=
g addr, int numpages, bool enc)
> >  	if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
> >  		addr &=3D PAGE_MASK;
> >
> > +	/* set_memory_np() removes aliasing mappings and flushes the TLB */
> > +	ret =3D set_memory_np(addr, numpages);
> > +	if (ret)
> > +		return ret;
> > +
> >  	memset(&cpa, 0, sizeof(cpa));
> >  	cpa.vaddr =3D &addr;
> >  	cpa.numpages =3D numpages;
> > @@ -2143,36 +2148,23 @@ static int __set_memory_enc_pgtable(unsigned lo=
ng addr, int numpages, bool enc)
> >  	cpa.mask_clr =3D enc ? pgprot_decrypted(empty) : pgprot_encrypted(emp=
ty);
> >  	cpa.pgd =3D init_mm.pgd;
> >
> > -	/* Must avoid aliasing mappings in the highmem code */
> > -	kmap_flush_unused();
> > -	vm_unmap_aliases();
>=20
>=20
> Why did you drop this?

Both functions are already called by set_memory_np() ->
change_page_attr_clear() -> change_page_attr_set_clr().

>=20
> > -
> >  	/* Flush the caches as needed before changing the encryption attribut=
e. */
> > -	if (x86_platform.guest.enc_tlb_flush_required(enc))
> > -		cpa_flush(&cpa, x86_platform.guest.enc_cache_flush_required());
> > +	if (x86_platform.guest.enc_cache_flush_required())
> > +		cpa_flush(&cpa, 1);
>=20
> Do you remove the last enc_cache_flush_required() user?

Yes, I think so.  As I commented above, this RFC version doesn't remove
all the unneeded code.  If there's agreement to move forward, I'll do that.

>=20
> >  	/* Notify hypervisor that we are about to set/clr encryption attribut=
e. */
> >  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc=
))
> >  		return -EIO;
> >
> >  	ret =3D __change_page_attr_set_clr(&cpa, 1);
> > -
> > -	/*
> > -	 * After changing the encryption attribute, we need to flush TLBs aga=
in
> > -	 * in case any speculative TLB caching occurred (but no need to flush
> > -	 * caches again).  We could just use cpa_flush_all(), but in case TLB
> > -	 * flushing gets optimized in the cpa_flush() path use the same logic
> > -	 * as above.
> > -	 */
> > -	cpa_flush(&cpa, 0);
> > +	if (ret)
> > +		return ret;
> >
> >  	/* Notify hypervisor that we have successfully set/clr encryption att=
ribute. */
> > -	if (!ret) {
> > -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc=
))
> > -			ret =3D -EIO;
> > -	}
> > +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc)=
)
> > +		return -EIO;
> >
> > -	return ret;
> > +	return set_memory_p(&addr, numpages);
> >  }
> >
> >  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool=
 enc)
> > --
> > 1.8.3.1
> >
>=20
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
