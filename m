Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97786F4F6E
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 May 2023 06:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjECEWy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 3 May 2023 00:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjECEWw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 3 May 2023 00:22:52 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510C6210D;
        Tue,  2 May 2023 21:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIX0NsEqXlxjBuV+z3lpVjMeduOj+RWt3DWEQW/YX9/xvnwOjBvNxH5hPDvx5r3ypIynmawqZsJ6lnLKJcT4xOcjJXMLisIaZRzsuhDzoKAXRTirHYMNZENLlQy8utMSnEUc6F9slpyTwGugbFwFizLTUdaMqWeOFDXGxKldT462dnh5/kBsLGpwy+S29aGvKFXuPtUYdC7RRIwfHRVRaog0Foq4m/uMsPO1Limp0svxqIq7JhDoDCWpb4K1bxfcFuDuDgVyo28VfzTZ8Qr70tc6YWj8CwBmM9/VcO2TxN22LPIFfspmyOgGcYlpxtUT94PUQJTCpSn8YZEu1F2S4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEbWF04JB1+jJ2e/vZRLaUQDQhU6GPACa5+X14xXBfA=;
 b=nJvmAFRblAAsjjZmfjspG/CN//djt467hPSelBXUVIm1FnzJu9rgpkAhqBAcfRcHKtigjNXqWGJKE8TbbRpdBLBoRBImlnIHJYb0oly/SZC10s0qCn0x5hrcpwYW6GbZQKVnuT9HUavxt1o+8uUrR/14T6ebLHqemuCt52R41v8CpMk2Y7Cddg6tfMlbGmpzStk4Nw8CkfffSMpc1MfD2QXhyldDdxtpo+yvolymSKVcEm/Zux8JDP+X7gA0sMYj7ERdIjUML3OyQQPKhny7VRJAlNvDEt1NXME4p6ht7oZOlgzYZF5xQU87Q2sP+07TFq6iY2xGru6LDqFwAc54HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEbWF04JB1+jJ2e/vZRLaUQDQhU6GPACa5+X14xXBfA=;
 b=AcnimC9uDbYIbBVE395BH32ulUHT4KZJB6XqIyMk1/PfkEYTZPdcteELcaDyIb3ZofLsaIROLcEMksfetG6jkHnIw35CRtXcYHMEgF0LJA3JOp6Srn2bVdzSV8xFPI//cfSfnV0mioVWrWmbSFQWoH0hS2dzpcvmUUgUP4G3LpY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ1PR21MB3672.namprd21.prod.outlook.com (2603:10b6:a03:454::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.5; Wed, 3 May
 2023 04:22:47 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.008; Wed, 3 May 2023
 04:22:47 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Thread-Topic: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without
 MTRR
Thread-Index: AQHZfO8AidMlTOanxE29vr+R9vbz+69H8llg
Date:   Wed, 3 May 2023 04:22:47 +0000
Message-ID: <BYAPR21MB168878186F9642843E8480BCD76C9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230502120931.20719-1-jgross@suse.com>
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=623c2fcc-89cf-47dd-a85a-04fd8fadfa20;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-03T04:17:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ1PR21MB3672:EE_
x-ms-office365-filtering-correlation-id: 0c1bf722-548b-4607-f879-08db4b8e0cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fwCBycC5zSlUwDxiBf74VJaq8hMw2JHL6NjE1faRai7H37vkQew8zG7pgu9wrjuS9Nj7cqskAsjPm7/YGDKG8BTqFus85NLKQlaQiDJKUgBgJYDUYH6bIW9nENgue4H/EHpW+adBZiMaBRibZxvQDhvdEmA2n98rkqFQFHXiw/mBQaNwPaNoz8ow9E8fI7H38f26YO49HIm6U7AP4Vv27xlB1ekG/4MOcDKBqOjm5i36UN17AgG+L7x7Q3lfjrL+4tOU/0Gg4U1Zwfnp5JsIlmagCrXcyzmCIxHsZ55w6XODEYG19ZbKIbJ2QhGNV9SPxmh967Set4Ke6/5ScQehV/BbqNDwh9oydXxTjxlGgJ4+DGZGkBVpkONs9gMvK9N7mb0QoLX6cvf/EMCBaR7nr3iNiE7FExXVlUd3KCANZGl4vga4HtGrHu1In74MtEVUD/uqCLS4omRP61weN90X1CYKsilbl4KulrR9vAwmqjIKvb3Di5U4yjUlWIi/xzcGAI8skQ3CWGUsQuQHVSf4tDLyQi/lXIk1Py54Qym7QQMA34TPAIbjVZKpJF40x7c6tM/2VGi3zGxlqlmfDEMXGh17LZO0KVXNx/kUC2slExoq6YnVxSp/hCasEJQQEUJp8r6FN7U/KDTTuHZGTQhWOGt2YEAlHe/dNlB0ytzZtIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(52536014)(8936002)(5660300002)(8676002)(7416002)(41300700001)(82960400001)(316002)(786003)(82950400001)(33656002)(38070700005)(86362001)(2906002)(122000001)(38100700002)(55016003)(8990500004)(10290500003)(26005)(54906003)(6506007)(9686003)(83380400001)(478600001)(186003)(71200400001)(7696005)(76116006)(4326008)(64756008)(66556008)(66446008)(66946007)(66476007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Be8axflG7PfbcOl6TqBYxOmhTBdjq/lv27ZadRFiFK8L2wVavNNyLiPmVMy?=
 =?us-ascii?Q?UqZXpDRAbchH/dWmtdQeFzHeGIkkRZXD0M0av4NZu9lGRivjSoeqQ0CrQIxl?=
 =?us-ascii?Q?60rt+Vq6F8ATV4JRra3Lmv4Fu/xOaLQZLCj05cBT0+UkyZnO886CUKbdgwTq?=
 =?us-ascii?Q?QtW04zG+LF+y8mkWZbtB063JHSJf1ywDpdveLssOzjwdqhE2cJH8xDRjsHDB?=
 =?us-ascii?Q?6+V1R1W3RBCyYOPMcpwXOP/MoLoE9OCrBBD4NNWH3+OEnBUApNG53Z0FN3hC?=
 =?us-ascii?Q?ZvXxSWyeuZKqAv4qyhkkuKNlq6aWcXBnPe2aHO3ikkhXf6qRCFvdG60uMqca?=
 =?us-ascii?Q?aHkCplQYZ28+7lbkNizN0msrQ+z4xha2Bfj6LN36ZwFYFr8OgW7SPrpWRqNk?=
 =?us-ascii?Q?4LTRN4CkfRpBJ3QHqNdVtlZQeICQAHHvtH3rT70x7yklyzjFvNYS0t7IVUsE?=
 =?us-ascii?Q?e3zs/g3a5Di1QIj5aRKjmDM0dEewWQ8jja4ILX6d/hw7CoquWpi/nExgdNr2?=
 =?us-ascii?Q?dwNQyc8Vz/6G+bzaFSDGd9fYJlF1Hopns8i0abYt4+JkEgw8ml/9ql6JV9dC?=
 =?us-ascii?Q?289CyZ2P1FFMMJBX4qT+m//wTl9FuN5dwzO/YLb31g7KfU6BT7had5u0DJxq?=
 =?us-ascii?Q?uw3UxtRTyAnkoJB+BLlruNtajJVEg+Gj4fqg67L3krAeLFwc1MyBZGI9o6fI?=
 =?us-ascii?Q?PcWRwa8ToFHdY0gmpbEPO83ByBqjaPhT84/dTC/HTpzfGZjnlyce1pjvH3z2?=
 =?us-ascii?Q?9l0lak9bQKqz4CIpJl47MGaOhOaQQ4fb71Fb+ooqYXVQfj9JA107gbVAfGXa?=
 =?us-ascii?Q?6cPCPQimkeqFwUUL0I3P9XuhnQqMJrBwbsXuTn5PLysRVo28uU4ZswvZHoxe?=
 =?us-ascii?Q?6nj08xlzbQce9LqioNqDGNJFxiwBXNw3epoP0inHSzioHW82vqVRwdAXosAE?=
 =?us-ascii?Q?GGez/Gq2jwsT0P5sH0P2t84CoZLTDQIjPdbycqtOuGe0HvSCn+x7xk1l5Ony?=
 =?us-ascii?Q?GpJ2CybBKhYz51VS3VYreNFpGl8M+6wp8J1f0zX9Vz8vU4y2h5LLFD9t8EOF?=
 =?us-ascii?Q?15qKoo44bXv0CEz8iz/GEo+LxHlN9YWX+7QYkdaAHbcfDe/Xivf5EuGQXcZp?=
 =?us-ascii?Q?gSwBzYOPYY035u9nifu4QQZWQYRpihCrJz4dDitRUCsK4I+M2bzeQxOJ7upB?=
 =?us-ascii?Q?og096lBeMmE36ekMsgsISyqpY/Uj4up0BixRrE7SbN8dhfaVqvUb4A+BFjWR?=
 =?us-ascii?Q?QeZHvwXub0uROgb7t2iGl3HqkKtDdP/aBBOdVPCcZMVGEr9P4jY5VKPP5/QK?=
 =?us-ascii?Q?wPISdH/59BAiS9V63EQmZA15fJ6OCnT4scO3RBM1skDr1cMNLEJnc6lhg8RY?=
 =?us-ascii?Q?5/dMDlAE0K10GgL2kiKsQL5teGAtWrCVcPSy1Pd7ngwhvKakdn+OSZoY7uhz?=
 =?us-ascii?Q?eV1ftHiHKKL2OClkRuasqtaSZ6tNruLpiyhF/lBJlvhcrRgsPAbz1+sFMBd+?=
 =?us-ascii?Q?5eWkAzVQLK9QXCch7FcUDD5RJBSibQmK9C06juqV1+8giA12z45qdqRgvCeW?=
 =?us-ascii?Q?qpb7AqTih8BSHE9zdznG9sEiKY6mIp7k5YB8QlnA69pmaErR1ooEMpHYVeiw?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1bf722-548b-4607-f879-08db4b8e0cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 04:22:47.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4oz+y3a+0Vw8WA7Yyy7owpm/xWojADSC5j6iYwY6aydHvqP9XDf88eWc5mo3pwV5g7MITimVS8bEgxbVTFOLHfvMUMBbAfxxuOAAsxlbEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3672
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Tuesday, May 2, 2023 5:09 AM
>=20
> This series tries to fix the rather special case of PAT being available
> without having MTRRs (either due to CONFIG_MTRR being not set, or
> because the feature has been disabled e.g. by a hypervisor).
>=20
> The main use cases are Xen PV guests and SEV-SNP guests running under
> Hyper-V.
>=20
> Instead of trying to work around all the issues by adding if statements
> here and there, just try to use the complete available infrastructure
> by setting up a read-only MTRR state when needed.
>=20
> In the Xen PV case the current MTRR MSR values can be read from the
> hypervisor, while for the SEV-SNP case all needed is to set the
> default caching mode to "WB".
>=20
> I have added more cleanup which has been discussed when looking into
> the most recent failures.
>=20
> Note that I couldn't test the Hyper-V related change (patch 3).
>=20
> Running on bare metal and with Xen didn't show any problems with the
> series applied.
>=20
> It should be noted that patches 9+10 are replacing today's way to
> lookup the MTRR cache type for a memory region from looking at the
> MTRR register values to building a memory map with the cache types.
> This should make the lookup much faster and much easier to understand.
>=20
> Changes in V2:
> - replaced former patches 1+2 with new patches 1-4, avoiding especially
>   the rather hacky approach of V1, while making all the MTRR type
>   conflict tests available for the Xen PV case
> - updated patch 6 (was patch 4 in V1)
>=20
> Changes in V3:
> - dropped patch 5 of V2, as already applied
> - split patch 1 of V2 into 2 patches
> - new patches 6-10
> - addressed comments
>=20
> Changes in V4:
> - addressed comments
>=20
> Changes in V5
> - addressed comments
> - some other small fixes
> - new patches 3, 8 and 15
>=20
> Changes in V6:
> - patch 1 replaces patches 1+2 of V5
> - new patches 8+12
> - addressed comments
>=20
> Juergen Gross (16):
>   x86/mtrr: remove physical address size calculation
>   x86/mtrr: replace some constants with defines
>   x86/mtrr: support setting MTRR state for software defined MTRRs
>   x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
>   x86/xen: set MTRR state when running as Xen PV initial domain
>   x86/mtrr: replace vendor tests in MTRR code
>   x86/mtrr: have only one set_mtrr() variant
>   x86/mtrr: move 32-bit code from mtrr.c to legacy.c
>   x86/mtrr: allocate mtrr_value array dynamically
>   x86/mtrr: add get_effective_type() service function
>   x86/mtrr: construct a memory map with cache modes
>   x86/mtrr: add mtrr=3Ddebug command line option
>   x86/mtrr: use new cache_map in mtrr_type_lookup()
>   x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
>   x86/mm: only check uniform after calling mtrr_type_lookup()
>   x86/mtrr: remove unused code
>=20
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  arch/x86/hyperv/ivm.c                         |   4 +
>  arch/x86/include/asm/mtrr.h                   |  43 +-
>  arch/x86/include/uapi/asm/mtrr.h              |   6 +-
>  arch/x86/kernel/cpu/mtrr/Makefile             |   2 +-
>  arch/x86/kernel/cpu/mtrr/amd.c                |   2 +-
>  arch/x86/kernel/cpu/mtrr/centaur.c            |  11 +-
>  arch/x86/kernel/cpu/mtrr/cleanup.c            |  22 +-
>  arch/x86/kernel/cpu/mtrr/cyrix.c              |   2 +-
>  arch/x86/kernel/cpu/mtrr/generic.c            | 677 ++++++++++++------
>  arch/x86/kernel/cpu/mtrr/legacy.c             |  90 +++
>  arch/x86/kernel/cpu/mtrr/mtrr.c               | 195 ++---
>  arch/x86/kernel/cpu/mtrr/mtrr.h               |  18 +-
>  arch/x86/kernel/setup.c                       |   2 +
>  arch/x86/mm/pgtable.c                         |  24 +-
>  arch/x86/xen/enlighten_pv.c                   |  52 ++
>  16 files changed, 721 insertions(+), 433 deletions(-)
>  create mode 100644 arch/x86/kernel/cpu/mtrr/legacy.c
>=20
> --
> 2.35.3

I've tested the full v6 series in a normal Hyper-V guest and in an SEV-SNP =
guest.

In the SNP guest, the page attributes in /sys/kernel/debug/x86/pat_memtype_=
list
are "write-back" in the expected cases.  The "mtrr" x86 feature no longer a=
ppears
in the "flags" output of "lscpu" or /proc/cpuinfo.  /proc/mtrr does not exi=
st, again
as expected.

In a normal VM, the "mtrr" x86 feature appears in the flags, and /proc/mtrr
shows expected values.  The boot option mtrr=3Ddebug works as expected.

Tested-by: Michael Kelley <mikelley@microsoft.com>
