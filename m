Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C19619C2B
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKDPwm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKDPwf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 11:52:35 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022027.outbound.protection.outlook.com [52.101.53.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B82D763;
        Fri,  4 Nov 2022 08:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6fBmbYGxYNe0ekdwK2W3tjkfNbVq+rMZ209tbTZfiqdZVnI5A+VeTNcJxYO0atpibszTjn+MKt8qTKSxIhSzECUzl8AO7Xi3vTpnezEYwvLIsWVf9NMPWX/Z6eXlNx41p4P9RJFN+kXpvu7/ppjWo2Avl14cwKu9pyZmz0koupf33eACj/n7BmgkIg1NyAY8N+HeHRakNhOfywEhGQEiODEpM4sp+XqZo6CiwDmhAUzdin9G0DG9ylaUfymKxOykm/LEAJ17R3mU4D31N1Gpz0iBK+/olWwfFmp1rfVCA8omVDwA1WmjKubPXLu6f+npnejB5xHKjWfWuJH5vfkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/B0JLbnZPUg/FgI0z/TTv5rr5N/pV5+XZdNNAfz+Qo=;
 b=Uac+DRuKwHMY0vpL05pb7pg0koutkSfp/HldEvvTEM6FQyLrX1LUQGczfRizSbQHBMe2FvLXKj/LYLEGSAEw8XyEoV2J3myaD/7D95QJTAWUSBaw1kTzStUvKVeNXS0PKv88nXwvS8FA52e96Oq9b/E3mEJi1uwCpno3g9TOrbdhpiv56Ax7umSgD6uNWeaPQwuM69V9qB6LsWAipx7UxZdGZ4CudRl8qoY+x4K7ryaqos6KFFl4BQPfu9upU4fnSpoH5v3B1ns/7EC2NHqdGxupsV1OeSFQ1YCco87zdKsWd1XVg6LnHPHH+PUofaACun4Tpw4S6kLI0+UnG0Lh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/B0JLbnZPUg/FgI0z/TTv5rr5N/pV5+XZdNNAfz+Qo=;
 b=ZBWWLgytQKd+gtU3/T6oozz9NhOBoD5r0AsYYLpjraWPNze4B/CLm9kAmLTP8RM1vo2Qt1rcm0BP4v4yfV8Z8P2bzmuGCczcWNxLwun53O6DfGebwLM/b0KmasZRsyW22+icIjSbWCcIVz2fi4CSYvqGy0qvwkjzmJObpk3nwYk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1470.namprd21.prod.outlook.com (2603:10b6:208:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.9; Fri, 4 Nov
 2022 15:52:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 15:52:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/Hyper-V: Expand definition of struct
 hv_vp_assist_page
Thread-Topic: [PATCH] x86/Hyper-V: Expand definition of struct
 hv_vp_assist_page
Thread-Index: AQHY8AnguhusiAg8Nk+TLSphz3eeHK4uWsSAgACOI1A=
Date:   Fri, 4 Nov 2022 15:52:28 +0000
Message-ID: <BYAPR21MB1688DE692BFEBDF3111DDA8FD73B9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1667537814-15939-1-git-send-email-ssengar@linux.microsoft.com>
 <Y2S8aT7ltuqcHGVN@anrayabh-desk>
In-Reply-To: <Y2S8aT7ltuqcHGVN@anrayabh-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bb53d6a0-afc5-4241-a251-b3cff73b7864;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-04T15:45:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1470:EE_
x-ms-office365-filtering-correlation-id: df30a624-9728-4407-82e2-08dabe7c93b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QPrYGImaUAA+W/tTtBDgammXIbuExamtlxWQxWpg3B2NVHRGbeOb5cb1bOTunckGf/T6gTt6T1ByDOe4QcWm7KciMUtQ4bIjXnmkR4FYqBUp6P3+DgJoQgljx6G4TGiUu+oGgVgL0zhA3d7M/LT681bDxyky/AdN+qoOrKleBu40bCaOZvIjrOyK2I/k6GyOdxdthKTKshCdt7n1C2kv3+iAgfCp75ucn2Px6PN/IkKWSKEBhz5WBEuQtPtwxTODrXAL6IbUCERCb6QWDCvRZ8Ld1cHSzrOSOvKVdac8HqrizurjqMb3YXr/C6vVEovDYUoTzA9cTL3Vqo+2AnlndWQaV4JyRHQ7E5xdgi2zIyvJ5uCia44MruHo0ERYCd5iNY2dPieydW8qVtXkNePuv1HJ2t0wozTbfMFVFKwlQgmIiTKThE7eWlLCCNTlMGdNH7rx7a/RVuqWcnSLCaDF0or01wj7ZQLCiB1qokCkceiRjHPbDG3KlhTRyIpRgbpV2G7gt6v4kZV0NjliI8YUd+wqeOob0q4HLTITunBp3izcrj3CvLTkOauE5K4SG+Cf+ezAofvNpFWRzpQsOEw9hbSr6VFYvHaTMlHcBFHJ9T3r2tfT4R6Q7aTU5dSxlrkITtTaS0wxkTBaj0kG/vA2St9wLCaetyC+MXqgqBQZZ3SU1ji+vYf/dflBD0PIiTZpGXwh6EsXLtmewXgcKaTmNnViPTta9OrhHLp0f2XG2WhFAfFJU8zsvyHClkzCqcqzcOcycgHXFGJJhouEfCSZUk1Zc+vh/QDuJjSY6+/4dLK5Ah7t1WIkyrN+ZrUyFGrE1ht7hibhD5MMfTQdazC7ZSu1/QxxjmtMI4N27kpq2Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(8990500004)(2906002)(83380400001)(33656002)(8676002)(66446008)(64756008)(76116006)(66476007)(66556008)(26005)(4326008)(9686003)(55016003)(41300700001)(86362001)(38070700005)(66946007)(122000001)(316002)(110136005)(82960400001)(38100700002)(82950400001)(5660300002)(52536014)(186003)(8936002)(10290500003)(7696005)(6506007)(54906003)(71200400001)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dHI9X+LApWEoa8IS2dZTGsURpf99OR8Xx9+Eh7gwtBKSu2plTTMeEeboDCON?=
 =?us-ascii?Q?IxEfsOEXsfyqdzVe5dan7Tp3BWEdCIRRx+2uabV8yLw8ziNy8C0vTwsn7NQ8?=
 =?us-ascii?Q?Z1HdOndAqeoVegeVegKYmJrOUL7OhOOT6GTHur9Zb11eWH4rSZvQT6kYUtX4?=
 =?us-ascii?Q?YriblOZDHh0tHQFkRc9Y9bmGizkyriP5rHxETcXRMjfRtp7W/XSZtXovzx+e?=
 =?us-ascii?Q?XzuPWLC+yND8BHa2gBJffFVB/dxavJgsPM9jezPkGAo9mp2/BCJvQjkJMRU1?=
 =?us-ascii?Q?vlbRIAQy5ZLJBenbWGzAB/gjPZn0hUqsyjEHiBlogZ6sYyLUCM4MWx3ea77q?=
 =?us-ascii?Q?JPP5j95YoD1ewzN6tCiThPoqxSRem3OM8jWrsSkG8ucMJicg1k5FZPPAG5zx?=
 =?us-ascii?Q?kzZ/1g4D9jl7AY9x9CKBa8Kk6FbsyFF7DiONr18G8E7v6g1v2BiHI987JPhM?=
 =?us-ascii?Q?Ll5P6n1pbUlQwBnaBvG9sEyiDXt/P9LazDfw4UOzXPfpbH9zquIjR22DI9Wf?=
 =?us-ascii?Q?39bHpsLWlQdZnvToixd7ABVbEmRrQZIcd7mqN20jC0qEleULMbkaR1U8FT1a?=
 =?us-ascii?Q?thEvRAGM+flEBbbrdWp204LxV51luYPTcNY/n5mVqdC2lrSOog3NFENYIBI6?=
 =?us-ascii?Q?UDR3LgXVyBCYNyOoIX9buD/WcsQhQTGrIcjNniiKqOYRsYGXll6taKKbtDHc?=
 =?us-ascii?Q?RTTWIRJTmSM5zfHMURCZf85W0WLn7Wt1twB5XSU3NGQ9+dPrC5cMyEL3IAaR?=
 =?us-ascii?Q?xU/ZxrUQ7BtrrhEBiZt+fCJCfzScryLSzUPOuzLdwtUAkJ/zCYoEK/BmiGuD?=
 =?us-ascii?Q?OzTaZjsbI0OWZ8B7SeIJGZW5iEUrYLseUCifijyg4Nf0jphhiO1wu5mJzgUy?=
 =?us-ascii?Q?+jVl4mVxCaxJLj0lX8bPjZPJ88eg9SVC+gkmILM94wzALXsR0iPlGKjybZzO?=
 =?us-ascii?Q?3aYfRhVWod4MdyZKhSJYg32FaST1JY9VFfsniA75bKIctHWBEdjVh0IqcK6p?=
 =?us-ascii?Q?o/t94XcDf9y7tEThhGXiY6U7bXAU+OSvg3E5DJLUk13O+SMHwL83jYMhKQLG?=
 =?us-ascii?Q?KyUI+D/MXkrQ4eWueUJLJjfx8/5Snb7ZlYl1WM7/yAqHhSwkFZZZVLu2wgV1?=
 =?us-ascii?Q?9PnCM8zndskdZHwtg8mcSZwM5yzuXJCKWQ9TPDYtVYLUJ9fDmt/SmnygyjW8?=
 =?us-ascii?Q?qp0lpxoq7J+zUjriCwohPCJ8qBSWiiuhyExuW8N0Us81ad5rKCE/14naxIPn?=
 =?us-ascii?Q?ZsSjGCNVbhXBkSzKd/tUUkNy384Oe31/F1/MwniUJgZrJ+gAbNx2CPr5RbLA?=
 =?us-ascii?Q?O3M7rElXRO1Iv/ip5B/mUU9yWNyWomI133ZJS81Sz2ceIz1jv0O1QsfRo9ff?=
 =?us-ascii?Q?x+cFLwCuv6CRBIt6HLqqVoXRn7XS9zZ7F/iSqsEPFsUqnRs9sjC6FaEp5SIq?=
 =?us-ascii?Q?aeJSjHRaUuImhcia0+DUvxida/tbPRk4QhmvINVeBkLrG4G2ppcnFzEjFfYm?=
 =?us-ascii?Q?9uG4M1JbUPhSJ30tpGTF9FqWq/A8OIwVrYtVVENwHuk8rR/280RUvqGHxiDh?=
 =?us-ascii?Q?vIGKsPIpGbeCa1bgmRcOjuLKB/NxRpwekhvs5wH5D00UnDKHVh3H96BiMsvC?=
 =?us-ascii?Q?lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df30a624-9728-4407-82e2-08dabe7c93b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 15:52:28.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj70LpiB3D2XvprkRMQFibpc3ij9vv4x+0Ssox5l8ocs1WpW4Ri63FL3K0VKpkRKXXTNNvnkQFW5Sr7bsD4EHt/Dkzl49BPQ7A7zjrjM91o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Friday, Novem=
ber 4, 2022 12:17 AM
>=20
> On Thu, Nov 03, 2022 at 09:56:54PM -0700, Saurabh Sengar wrote:
> > The struct hv_vp_assist_page has 24 bytes which is defined as u64[3],
> > expand that to expose vtl_entry_reason, vtl_ret_x64rax and vtl_ret_x64r=
cx
> > field. vtl_entry_reason is updated by hypervisor for the entry reason a=
s
> > to why the VTL was entered on the virtual processor.
> > Guest updates the vtl_ret_* fields to provide the register values to
> > restore on VTL return. The specific register values that are restored
> > which will be updated on vtl_ret_x64rax and vtl_ret_x64rcx.
> > Also added the missing fields for synthetic_time_unhalted_timer_expired=
,
> > virtualization_fault_information and intercept_message.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/=
hyperv-
> tlfs.h
> > index f769b9db4630..b3d0f42853d2 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -377,11 +377,20 @@ struct hv_nested_enlightenments_control {
> >  struct hv_vp_assist_page {
> >  	__u32 apic_assist;
> >  	__u32 reserved1;
> > -	__u64 vtl_control[3];
> > +	__u8  vtl_entry_reason;
>=20
> This is defined as an enum in the TLFS [1]. We should do the same.
> And since the TLFS defines it as an enum it is a 32 bit value and
> not a u8.

In the *tlfs.h files we have avoided defining fields with type "enum"
because of the potential for variability in number of bytes it occupies.=20
The TLFS documentation assumes an enum is 4 bytes, so in these
structure definitions we use a __u32 type to be explicit about the size.

We do have enum types defined in the *tlfs.h files, but these are just
lists of related constant values, and that's OK.

Michael

>=20
> > +	__u8  vtl_reserved[7];
> > +	__u64 vtl_ret_x64rax;
> > +	__u64 vtl_ret_x64rcx;
>=20
> The TLFS groups the above VTL related fields into a struct
> HV_VP_VTL_CONTROL. Any reason to not do the same?
>=20
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/t=
lfs/datatypes/hv_vp_vtl_control
>=20
> Thanks,
> Anirudh.
>=20
> >  	struct hv_nested_enlightenments_control nested_control;
> >  	__u8 enlighten_vmentry;
> >  	__u8 reserved2[7];
> >  	__u64 current_nested_vmcs;
> > +	__u8 synthetic_time_unhalted_timer_expired;
> > +	__u8 reserved3[7];
> > +	__u8 virtualization_fault_information[40];
> > +	__u8 reserved4[8];
> > +	__u8 intercept_message[256];
> > +	__u8 vtl_ret_actions[256];
> >  } __packed;
> >
> >  struct hv_enlightened_vmcs {
> > --
> > 2.34.1
