Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA896AF73B
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Mar 2023 22:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGVJ2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Mar 2023 16:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCGVJ1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Mar 2023 16:09:27 -0500
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC99A0B34;
        Tue,  7 Mar 2023 13:09:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF9/OdLrivLbzj+PJnkoJWNeEMMfCXsxtCn7lGRPWs1NqZiRg44iqGhZxczATUgfYc8e2U2+XrikT2oYL6Zi2tDKhe6nRgnELGh4WnEa4LmVJHq8Nm3cQ9KC0F8dZxsUhQ0hFlLxUP2CwcX8Lb2nTHTn+LHOAcGNlp5fx4znvWQYriYTpDRez5sxfAkGgwY/8LfQv30ZPqBI0nvQsIXbpuWo+Au0A98KnvcKcYkwEX58QfaTboecSvEsvIxXXyGDuXcZSD/dJbi3NaOXWQSkauMAsDhxpza7qOQlSbHiaAWUkcG0SI48cdb7MYZecIYELq5WUvtBmuADwfoKgUYy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIEaKjgrFWbRgGSfrWcOdWmNL5btujXYEYfw3wDX7tE=;
 b=iwG3kJIgEtDxUaM7XA5oGzdn+52DA8WhtKWe/Sp2urXD1ID+/Kr47ARnGMNKqCX6FsUqWdicRXlkJ0t9mYk2qHU9GONJcrED41HL15rpe6aIV+hb93WmxtbFvYb+H2E8Kw5agEi8c1lUg2TG7NIEIt3WY9cKqe90kLYFoXmKkJ9uYYIr24zGuo2tz0RocYvjsBL2ewA5O4egCPObXx2W5H6IWwqb8A4Bc4jvZaW3F5vSd9toNO3lsghafbNDKHQWPM+h2NW5FmKTUksFIfO3NrhL1pK9PS03u+shz5NG5155As0TbJeZKBMY/7lX6fwjO/0np0o0ddUxILiYHAAAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIEaKjgrFWbRgGSfrWcOdWmNL5btujXYEYfw3wDX7tE=;
 b=YQlW4NVxZDJ7kmuiMn0iV4ZGlmNIoaXVhjXM6IyKexBJUV8chl0Bvp2BARZPRlUESQXolrKAeacg/FLIipWZxsxNHQG+em92Ghe8D/AYcuYlu3mGeIgTuZSdSfWtKCs9O4PkbtOcYQIDHb3AowLWrsIhjcx9vn9CVZ94fn1NeAA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3140.namprd21.prod.outlook.com (2603:10b6:510:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Tue, 7 Mar
 2023 21:09:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%4]) with mapi id 15.20.6178.016; Tue, 7 Mar 2023
 21:09:22 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v4 00/12] x86/mtrr: fix handling with PAT but without MTRR
Thread-Topic: [PATCH v4 00/12] x86/mtrr: fix handling with PAT but without
 MTRR
Thread-Index: AQHZUEnfXAWHZPt6fU+0bsYvtV7j7a7vz79w
Date:   Tue, 7 Mar 2023 21:09:22 +0000
Message-ID: <BYAPR21MB16887D38D0A2F2EF1B6E2300D7B79@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230306163425.8324-1-jgross@suse.com>
In-Reply-To: <20230306163425.8324-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c109dd38-892f-4330-8e9b-47000582b9dc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-07T21:02:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3140:EE_
x-ms-office365-filtering-correlation-id: b015e6c5-3a0c-4a92-6db4-08db1f5039a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPvtkv1I08uKzSLRy3qvnj9RgdTT6290IhjxC7pN74fEf65l+3vF7tdwBvGH3bdpGvd0wLFI8hzCQLMxl2/JdqsOCV5fInYD+0pALOvdSmDb+RkpEUoJP3JAlmxs6cbWP+t1WYLyXh2J5/2AuN4AUxh8tCFpG8+2ssJWooHoYFsOAN2XUTDxBYEwl0Ck1d0szLZkFQWs0TR85b4MTIZdamttlmy04/MwRPEYGZMc8lPXdZHwpulE/sPNt5nIu3Kc6I/ZMHqLCl1GCWnK95UoroEhSDcN7QEsyRgHWwnmO6/9fx+qwN5lActinilA7YvjhblaiCPcYv2RbCI7lgFxSK196Ett+ABsq6WviPBq7YzsXdxzMrVNmvDaumjiFDvkiDXdieQl425IIDd6nmfnWeJuyIjgFBgHxDjwRj2NkHhyTP56x7K5eOyYEKeKbiZaZQLgVdg4oRCULaN7HSB+olvi30pu3w70uGCga0rkTLdtqFCdBzLMiVBog5dDXLlDNA6I6mFN8/Hmdz6nEsl+VjWKYDvSqVofcbPNVAbPKKEWKBMU7+YAKvKrhhEjNiEJYXrXL8iNMMye4acrpUI2OuuGLmyFnmoP0GHN2c2VfFV4KWR+76I+IzXdSXxScsqRNZOacDH3x2kd0H48g/SCZX/RmSYlFS/yY8UiC41s04IlvhWLTIkYYJ3vz0xbANjKdA9xfxY8GdyjKeWbtqeOn+y41oryuCkz06Im4nIA2gOaNDm55x8NDRKEAvFoPCj1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(9686003)(186003)(38100700002)(26005)(2906002)(55016003)(316002)(8936002)(71200400001)(54906003)(52536014)(110136005)(38070700005)(478600001)(5660300002)(10290500003)(7416002)(33656002)(7696005)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(82950400001)(82960400001)(76116006)(86362001)(66946007)(6506007)(8990500004)(41300700001)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Zllg+ZLwHIVNQ/RcCgjL0tBKNcDuA+EEGSpzFy4q6gd1rreP6qbHDMK4zMV?=
 =?us-ascii?Q?6+bTcNPZFIU7f8c6KBXmTMksjHNeHufY5A/bWy7211/fUxweOyhKUwFLy6I3?=
 =?us-ascii?Q?q0ipSgjgtumlz8q3K2GifdL+OiXSESXn5HJPHhMeXh5cPXDzwPeAYap2xuDZ?=
 =?us-ascii?Q?pkjoxPyA/NtjJnPyWApedC1h/eLRTm2pqG0xjsi5ui27Yv02GxEXalYDXsJd?=
 =?us-ascii?Q?XA2hkizTPwyj1soDW9Q0+qTfy4QR24UMu7/kQ7LQ4zPJf78XD/BK9X+yB0hP?=
 =?us-ascii?Q?9+YLOq4Vx0AVR9PPMDYd3pKkMVS7LHoJNG5oNJi+RJqjO60v8RMgemqYcAXo?=
 =?us-ascii?Q?EaIGSqBMp9rlLw8yUSq2Wyvazfh5GTw5PB2LWV4DstU+md0Kq5PDGUK6SfN7?=
 =?us-ascii?Q?lWsq+nDcnOQLm/J3jJuwnCtI1zEytmjGt9c4aDxdujjuSTDIXv6jx8nZwiPl?=
 =?us-ascii?Q?+1ngWjoI6N0xHm8DDe4ylOonPmR5W167+2XU07hUcic4woBSnc3h1V99W1Ls?=
 =?us-ascii?Q?1ea0+14BEqA8f23H+ZEWdcW6ytvTE4D87t45s/pNTMzp7+vH2E8MLDxPe0b/?=
 =?us-ascii?Q?RFh3WJzg5dY8Z5qkVm0I23qC00o7rtSUW3QdFsKItUy6BppGqgl3ORZLbWjO?=
 =?us-ascii?Q?/377HNyHR4yNRVffTLKvULHFflgCzosKV0mRw8PaVUK6dpLVGaI2b/fWd5sg?=
 =?us-ascii?Q?RSlruxlFFM+tuGlSUCUdClDqtyRGIN203cvGU+EHDV/tUCakTs9+cTTKUs8K?=
 =?us-ascii?Q?KFkWxAhhI+K5LIa8m2GX39r6OoojVX6pi2boPxalmwq9WwOpZfOYhTPYQ4ZN?=
 =?us-ascii?Q?A/kkYvEsyT7449FEzVgPxBwDFSrPJBC9dTZoxLGfP8jAQ1LQ3kUKLIkSxWwH?=
 =?us-ascii?Q?dUuxIgldfusM83Y0osBbOObRyg2iVMnHOGiWwtTfwc50tdwJAqsCEjNVxeBy?=
 =?us-ascii?Q?yCvbQTuSiviCfIod0jiURWGD5Mre/DAAMCoSoqqclteD9aH5FqZ7Z6KpOjqO?=
 =?us-ascii?Q?zeweKCiFgEmx0tdpL5LBw7haaZl1Qu0zcBfUdv5D/dBioQtS3NpueLU5fS0t?=
 =?us-ascii?Q?zk3jZZta0SuDovhY2LK0zqquzYIVhVKojaOr2nGPh3WPRYS5Uuc8WQ9LV/vX?=
 =?us-ascii?Q?zqFhBVGvGBLQbcdMD9HJbHGMa1xbLtJkFOkRjK51nhbaq/nf0SohRkoCvBEz?=
 =?us-ascii?Q?lPBUc7IGSdy4JHLVxBhiUf+yYydhr0X7UUbvcwefjDSVxCvgf/zR7tip3Vwj?=
 =?us-ascii?Q?Q7LdjEFNpUhBjSZ/4eX/0bA20EKQK0wSdkPJuiGv9ydKjVAerohqJiu8Hc1x?=
 =?us-ascii?Q?D5dsMpiWIBTQNr46rZ9R1j75O7B2PPm4zsAWjw+ohVsvJXKVYxDi6lKPfg0Y?=
 =?us-ascii?Q?DYTol3MK/3wFKjMzxDSQeWJt9Sq2QeN2sQCOD+p0id/9ffjsdvQv6LlJsYOx?=
 =?us-ascii?Q?1gh2VThorrvvkmdt90cAydIUF837wSN+e2JpG4QtAZPzdg4ryxsMar9YUNBy?=
 =?us-ascii?Q?OUaONsrmK6EXG7jmzqznMcgdGhdxTNIyUAGnaj9AE1V+lsrAPdOr4eldJc1p?=
 =?us-ascii?Q?KGLJaldC6IBID98yxoj5qP4rcgvh90cQ+1Q0E9HMQfOllgWw4E3k//+EaGkL?=
 =?us-ascii?Q?pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b015e6c5-3a0c-4a92-6db4-08db1f5039a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 21:09:22.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FmNEvBYBhIfXkeI/59sRaZd+C87DzO/Yqyc3rY1Y3qNorX/9JYuteMYNZ6ElJbWaY2lYAYRRUapv5yDo/Ei5pbt1Xlxo2K0QsbGHc3lepS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Juergen Gross <jgross@suse.com> Sent: Monday, March 6, 2023 8:34 AM
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
> Juergen Gross (12):
>   x86/mtrr: split off physical address size calculation
>   x86/mtrr: optimize mtrr_calc_physbits()
>   x86/mtrr: support setting MTRR state for software defined MTRRs
>   x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
>   x86/xen: set MTRR state when running as Xen PV initial domain
>   x86/mtrr: replace vendor tests in MTRR code
>   x86/mtrr: allocate mtrr_value array dynamically
>   x86/mtrr: add get_effective_type() service function
>   x86/mtrr: construct a memory map with cache modes
>   x86/mtrr: use new cache_map in mtrr_type_lookup()
>   x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
>   x86/mm: only check uniform after calling mtrr_type_lookup()
>=20
>  arch/x86/include/asm/mtrr.h        |  15 +-
>  arch/x86/include/uapi/asm/mtrr.h   |   6 +-
>  arch/x86/kernel/cpu/mshyperv.c     |   4 +
>  arch/x86/kernel/cpu/mtrr/amd.c     |   2 +-
>  arch/x86/kernel/cpu/mtrr/centaur.c |   2 +-
>  arch/x86/kernel/cpu/mtrr/cleanup.c |   4 +-
>  arch/x86/kernel/cpu/mtrr/cyrix.c   |   2 +-
>  arch/x86/kernel/cpu/mtrr/generic.c | 492 ++++++++++++++++++-----------
>  arch/x86/kernel/cpu/mtrr/mtrr.c    |  94 +++---
>  arch/x86/kernel/cpu/mtrr/mtrr.h    |   7 +-
>  arch/x86/kernel/setup.c            |   2 +
>  arch/x86/mm/pgtable.c              |  24 +-
>  arch/x86/xen/enlighten_pv.c        |  52 +++
>  13 files changed, 454 insertions(+), 252 deletions(-)
>=20
> --
> 2.35.3

I've tested a Linux 6.2 kernel plus this series in a normal Hyper-V
guest and in a Hyper-V guest using SEV-SNP with vTOM.  MMIO
memory is correctly mapped as WB or UC- depending on the
request, which fixes the original problem introduced for Hyper-V
by the Xen-specific change.

Tested-by: Michael Kelley <mikelley@microsoft.com>
