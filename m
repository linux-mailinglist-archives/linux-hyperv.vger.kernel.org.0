Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4E75C8CC
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGUOAq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jul 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUOAp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 10:00:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93E10A;
        Fri, 21 Jul 2023 07:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJlNLLD4BOYnbycTFxlSC5dVOpIARiWpcUk35HA7Nj9Xax4pmtpRfcXIgNGZccZ4t/+jT4DfNL1kMfz3YHhicpM3AA9xI90Pl85TQEBW3jXbGtZnj4fgJ4BjU/qQrfvY8MXUawqWURv5/MR/w+VpG+FVChVwQZ+GM7KIExFDpVhiiXbYd6Lqh0r5J/GjmDljtPwWVIKd92svZf6zAR5948Ke0JJ4X0DG574uQxqLrlFUKaaEnWgn2mrE6OsKX7zukG7rrNokYjVXdiM/iu8ycXVPiA+d4CHrgaZGGy5yc+kvhT3/KjQO6jdjZOyRnqEat+yz62xchq932uvtbDLrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E2B/0Ug2qYR5426R3aAywmzy22/fZdcJnWNhgSLk98=;
 b=K5vbzxYIGVz5xMoz8InR0fh0ct8Ic9I+S5ZeG/CjM2tdRNF9FSk7BzdQ7g5rEvvY9Mo8i0sg/Bl7hTQjA5SKyNTf6tTu5uIUo4Us3KW3WhlvV2giKDKztlcBpAYLXNR+g3vZ8yeqVFQXxIZNEh1MTtEHxasA3/1RDuGomSm/LIpI3qTd482HUYM1cbToVhr3Cv1+mb+vU1Ce3d+FgTvxbFgkBHpmPDVplX1zMB6vdQxU63jPjMX116O1Y12osA7ICPusTCeQ+SVEbDL26fD2pxMJ0PniWeAGBU38rGobyKSEmo1ecJ9CDjBGY47aFf53owuixpV7IdzKdej0fG3yyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E2B/0Ug2qYR5426R3aAywmzy22/fZdcJnWNhgSLk98=;
 b=RE7R2lMuroRft1vYzb+QRk854lTj9y585w6oKA0DGtgU+rZyFTEuUH8KR5/zTvCWjIEDAIbHrphgd3y0wQXoGxVTn8+ftWtaz8jFaj0NvXdts8O/Yk4P0PGKkgqmfZ3VXsG7yB6XX4awDlUkXjoq4R5e90VPQJnJLRIbdTtqZgw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM6PR21MB1401.namprd21.prod.outlook.com (2603:10b6:5:22d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Fri, 21 Jul
 2023 14:00:34 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 14:00:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Topic: [PATCH 1/1] x86/hyperv: Disable IBT when hypercall page lacks
 ENDBR instruction
Thread-Index: AQHZu0mXUyEtW9eyqkWnVGF605KOSq/DKCeAgAAzncCAAIAEAIAAYXnw
Date:   Fri, 21 Jul 2023 14:00:35 +0000
Message-ID: <BYAPR21MB168878CCD076762A1EA58635D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689885237-32662-1-git-send-email-mikelley@microsoft.com>
 <20230720211553.GA3615208@hirez.programming.kicks-ass.net>
 <SN6PR2101MB16933FAC4E09E15D824EB2FDD73FA@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <20230721075848.GA3630545@hirez.programming.kicks-ass.net>
In-Reply-To: <20230721075848.GA3630545@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ee767e0-9bad-49f3-980f-a3c711eb2908;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T13:47:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM6PR21MB1401:EE_
x-ms-office365-filtering-correlation-id: 80493a54-1fba-4c2f-c8e7-08db89f2db28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgcMZqQQDRcqBnaxlywPQCmodexeLi1vM1x3BGFNe+G+pLrKiXvD6w0SGUnHt433kv4Xgb8AfpLofnzK6BRPt5+JRh3qCbUneW/4M7gYEdd5w6lpTYJ5BHrh//bpVBPWlRAIWRCZIXJecePZOlFCiPbQIVMhTc/tw/33U5G5NbPX3riXUujjr9vehE3XwSiLonNjvfw+HDJ0JlwToUc1mfWvrP1rNgyT83ULKl4NN0IEyL1L/WEzE9OV1xJsxqLjuj+q3Ws5nVSC3Gt80am1BdfoKDk/LzpqgZh/CSZr9RhHzYAh0vFUFUQbb6ccVY+oJH+HrXw2VpE9PwmI4F5OUgWoMbMq5qVM44Kh+uDnZ9/LdwXLHtBetTRNjgDwDzTPX8qDpWlTYMzAz8aUtYNlo+uBxjMqy9rBbdvtnuQULsKadNXzy+1/hlBKBehOqnK1YYAYusS9f/PJRcrP0ieWVs0DDPlkY+sQ96E2FQvIJMfP4UgTeVOhqzIb/C7EDng3irOy5eLFoPGM0LIXETJQjLzTHHpdCx1GFsHHHSogJRwYLzBaCt10qO0uFPEXI7vlg4Xx8PYxCVbEORPCuMCMp2KM3xmoCRnzGJZtLnxvMVyoH3TZgmhgTH+zA3roN8KYy5z6v2lIg/16aYGd5XBOWqnDzIAXQTtCxKJI2/Uv6KM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(66476007)(64756008)(66556008)(66946007)(76116006)(6916009)(4326008)(66446008)(55016003)(38100700002)(122000001)(86362001)(9686003)(26005)(186003)(6506007)(38070700005)(83380400001)(82960400001)(82950400001)(478600001)(71200400001)(33656002)(54906003)(10290500003)(7696005)(8990500004)(7416002)(2906002)(5660300002)(8936002)(52536014)(41300700001)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Rs+Cy/ka9bZW+HCctRRH0vD+q81Fwbl+R9+ITHVgdNd/dWYfE2L99eBefTp?=
 =?us-ascii?Q?LKkzv5X3Zy8+m5iMVxCyTGaolDIqfiFJnWesrgJUFfXtJxHTXPcFh7tHXAyQ?=
 =?us-ascii?Q?hw4UB4R001EeIE774T3Xq43Dof7kwbyalH+TXO5rVk8jmWmWVPRQODC4Goa1?=
 =?us-ascii?Q?XCZ6DszxWtLsrlIOfT5+0A85go/iEiTM5CoXynhVqyN1SSCYWzTc32WCwioG?=
 =?us-ascii?Q?PWBgdrnr9SF6hOqYltKKP0jyfURLGoFuAxMqQhX7zTVEHgvqwCJHLThz5BIQ?=
 =?us-ascii?Q?2SDqgZII2XVgd11LC74lonpIgUbQ1nOKzLvoA8gI2UBriR3GLZf4ZbbZkKD9?=
 =?us-ascii?Q?XAch5yqpgN1/E5Ac7B9P1b0XsJCxPxSH1MwoannJaguwZvX6YYWSY3+Mrwg9?=
 =?us-ascii?Q?dq41NORJaWiTX3CV1MUKk1GR+zjgCVLi17KtoIv6dm6sBNur5UwMd8bv+f/D?=
 =?us-ascii?Q?I/1kck7DtD9awREEP3VtnL6f7n8Sk5bzWbjkqtjHz+aZSIVvMw2iq0HDHrF1?=
 =?us-ascii?Q?+KC7/6hg2tgDssVHORsJ8R8ghxyvxETa+DkxvdhrvjaXtD3riWeVRokQ3DiZ?=
 =?us-ascii?Q?VgjOvxi6yeAUT7ZipaV+tneMsvzgoQHIGrrgy63PoxCLdOV5yo7PCYUu7Kpb?=
 =?us-ascii?Q?TfBPz2SzM29rUbfOQaXwQbHlnwcQMeQGhER4fstKIrMCFkKQpfz3SDWoPdL1?=
 =?us-ascii?Q?CiM9ZvUQW9iqmug+0Hrip0U7bpDLhE5LRkyhHT/fX5HVbLgt9FNrrb6cv6p7?=
 =?us-ascii?Q?DgrW7/2jCNbCyJ71a4C9s/5L8QcBUgoXbxbJywNzRwAtgyzyx2uuhjRTLeTu?=
 =?us-ascii?Q?JNQrQPbVPO2c0u2BIdMgU2HWm1Oap14vMcpH5kSVQWCq5MFd+T7M4ApYt/Y9?=
 =?us-ascii?Q?pOi3fTlAN/+E73dlLpO0kbOH7OyOvymhN5FWVUwGFJYod1fLT32ugCn7lPgh?=
 =?us-ascii?Q?ogBaqj9o3ouywuHn5pZR5oeuEYKGh5F8LLxAYBZMwNs6fQl0EJw94D/VBYR7?=
 =?us-ascii?Q?3fmQZRlIuL7W6TRF9lkW244TXRVGZsBYQMVCq6nDIPr9mYraEp+cGlqy7iTN?=
 =?us-ascii?Q?yBxBiJXVVbdFh9VFDVIVIXNtFwyAnouKD6dimLyLfDJtMAjRZwd1g3V3aJaH?=
 =?us-ascii?Q?Fsnii+tAbQPvx8bTvJMUogWOYpbnZW6O7QsyHw6YFLG76AQGrO8Atm4DAbKh?=
 =?us-ascii?Q?zJl33sMNt+y01WMHEB6oLnfYVi6U8EmToUF7YKQUvpS147LoJLyzUmrH3V9S?=
 =?us-ascii?Q?fNk/R926SgxnLG9Ya2RIyI/beldS7IsqdK1XG7NcxO4f6ffDOKw3ypMSVd/m?=
 =?us-ascii?Q?Dcr5fZy9MT8t64eStCZilVztCmwUQr1WWo3FK2YKI46vMHF2M+7s18ugTumw?=
 =?us-ascii?Q?pOxBj/3ghi4UU7iZwYdg6YlzL3FvQMQS8ux+VmQjFaL5khhuZ2udmzvD/GP9?=
 =?us-ascii?Q?MHJNjI8czSsNAeFs9eVhHHE6hBKH1lZyOFlx4azxSn7toyjN4/KfXg8lzg78?=
 =?us-ascii?Q?riVCkBZY8Dl4E58J6fMxIctgKF330Ip33RsMJ0kzRxRe+fAHnrN4h0yjgWrJ?=
 =?us-ascii?Q?6ryNRaorBaz9zpNfDR/h2FHPj6zsjeIrdWepil8J8ntCdKNz1aLHBBYa+Wvx?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80493a54-1fba-4c2f-c8e7-08db89f2db28
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 14:00:35.4979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yi2aHMvKqXa8eSk3aENHJQOiZB3XkTXkYPPOsMoLJeuhfN+yR5/VXBhl2SFXmcRZfRgBcpBL6D4yS5sIxezuWwPzNMSmOa6rQttKuTntiCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1401
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org> Sent: Friday, July 21, 2023 12:=
59 AM
>=20
> On Fri, Jul 21, 2023 at 12:41:35AM +0000, Michael Kelley (LINUX) wrote:
>=20
> > > Other than that, this seems fairly straight forward. One thing I
> > > wondered about; wouldn't it be possible to re-write the indirect
> > > hypercall thingies to a direct call? I mean, once we have the hyperca=
ll
> > > page mapped, the address is known right?
> >
> > Yes, the address is known.  It does not change across things like
> > hibernation.  But the indirect call instruction is part of an inline as=
sembly
> > sequence, so the call instructions that need re-writing are scattered
> > throughout the code. There's also the SEV-SNP case from the
> > latest version of Tianyu Lan's patch set [1] where vmmcall may be used
> > instead, based on your recent enhancement for nested ALTERNATIVE.
> > Re-writing seems like that's more complexity than warranted for a
> > mostly interim situation until the Hyper-V patch is available and
> > users install it.
>=20
> Well, we have a lot of infrastructure for this already. Specifically
> this is very like the paravirt patching.
>=20
> Also, direct calls are both faster and have less speculation issues, so
> it might still be worth looking at.
>=20
> The way to do something like this would be:
>=20
>=20
> 	asm volatile ("   ANNOTATE_RETPOLINE_SAFE	\n\t"
> 		      "1: call *hv_hypercall_page	\n\t"
> 		      ".pushsection .hv_call_sites	\n\t"
> 		      ".long 1b - .			\n\t"
> 		      ".popsection			\n\t");
>=20
>=20
> And then (see alternative.c for many other examples):
>=20
>=20
> patch_hypercalls()
> {
> 	s32 *s;
>=20
> 	for (s =3D __hv_call_sites_begin; s < __hv_call_sites_end; s++) {
> 		void *addr =3D (void *)s + *s;
> 		struct insn insn;
>=20
> 		ret =3D insn_decode_kernel(&insn, addr);
> 		if (WARN_ON_ONCE(ret < 0))
> 			continue;
>=20
> 		/*
> 		 * indirect call: ff 15 disp32
> 		 * direct call:   2e e8 disp32
> 		 */
> 		if (insn.length =3D=3D 6 &&
> 		    insn.opcode.bytes[0] =3D=3D 0xFF &&
> 		    X86_MODRM_REG(insn.modrm.bytes[0]) =3D=3D 2) {
>=20
> 			/* verify it was calling hy_hypercall_page */
> 			if (WARN_ON_ONCE(addr + 6 + insn.displacement.value !=3D &hv_hypercall=
_page))
> 				continue;
>=20
> 			/*
> 			 * write a CS padded direct call -- assumes the
> 			 * hypercall page is in the 2G immediate range
> 			 * of the kernel text

Probably not true -- the hypercall page has a vmalloc address.

> 			 */
> 			addr[0] =3D 0x2e; /* CS prefix */
> 			addr[1] =3D CALL_INSN_OPCODE;
> 			(s32 *)&Addr[2] =3D *hv_hypercall_page - (addr + 6);
> 		}
> 	}
> }
>=20
>=20
> See, easy :-)

OK, worth looking into.  This is a corner of the Linux kernel code that
I've never looked at before.  I appreciate the pointers.

Hypercall sites also exist in loadable modules, so would need to hook
into module_finalize() as well.  Processing a new section type looks
straightforward.

But altogether, this feels like more change than should go as a bug
fix to be backported to stable kernels.  It's something to look at for a
future kernel release.

Michael
