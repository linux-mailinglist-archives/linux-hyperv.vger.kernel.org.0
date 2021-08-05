Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8313E1AF4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhHESIY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:08:24 -0400
Received: from mail-dm6nam12on2108.outbound.protection.outlook.com ([40.107.243.108]:57121
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229867AbhHESIV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDkQGiaTONnteHW8IQRx+zzCsDlZIu+ZTdjcg5y1Kceg4NeulI2vboR4tkr4RpOgoS450gbWLbwcOL5Rfqu/Mp9qRhhB8tY7n5WFHDOh85dGDhK7xkoLrithss9sJYADrt7J2tlUKgtL2ETyL8d0wlUHoZEMfQDacr3kzzQIB7fgfy/VZeUmTWYnmjg5U/Wp7qzYiV08VKmSZg2/crupp4cosfgRJ/c05W0Ut0gOnrek9EAInvWR/P5IgsprgSmg0aphtPEFk7M0HET9yw8/Cwy4a0c8F3H+EH+8raV7Qf+IqKxh1pFZIhD2SOjLvZmOWpDduPFyfTm4SMeQdBOkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSeQHNaqekeM5Ce6tsF/V7rNT8BqnUr+64xOjZwzE3g=;
 b=Fo47Euug8J3sVk22/5givhR+6/bIIRCC6X120rrLL+SEKnBwQpL6QxNKTJRwIo+qu9pVKP+UeicZG1BznpSU0qnnjdia7rpgiAVo6OZWgJ5yrOzLkcFOP/9gaQo0k6xufJmSp7hgey8/r5ZFnHAQb77+qscPynfZyG2yy+HeQjnoLaz1lyc4u8wSfHBe6+YPyrbt4TtTxN0zBN3AJhJM/7naMbLfD0AS0SWWMC/n++T+p0tQlg4Bux7zOybsnZ7zWCHt98GzvtLx70DB8rurV0vH4sY6WbweZM5OYUrnZyyjXiu/T8KO0zq+pyMsThAiJUsmtjDRhAQSaH+D9k9/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSeQHNaqekeM5Ce6tsF/V7rNT8BqnUr+64xOjZwzE3g=;
 b=eclr25pc9wsFFswWrDXXdvUahagHI3F4bA6izQMBgMn+HGDLqbEmve5H4l4UfByIeXIIf7niAZgnfTFWZZ2b1QfWXs+MVzH4rg2h9V6mPDRH7zcR3ascyRufisdHi6psdQgMst5KJ1Ry4g9ATWIVUs7TGtFvh7lSCBRIAYSDzsE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1300.namprd21.prod.outlook.com (2603:10b6:303:163::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Thu, 5 Aug
 2021 18:08:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 18:08:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     David Mozes <david.mozes@silk.us>,
        "20201001013814.2435935-1-sashal@kernel.org" 
        <20201001013814.2435935-1-sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AdeJIrv1C1ZBRIv3SEuOCi2rqG3H6gA/2C5g
Date:   Thu, 5 Aug 2021 18:08:04 +0000
Message-ID: <MWHPR21MB15937C5C151589EE999ABC63D7F29@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <VI1PR0401MB24150B31A1D63176BBB788D2F1F19@VI1PR0401MB2415.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24150B31A1D63176BBB788D2F1F19@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ffc0731a-56d8-4185-8106-f7cdc569b264;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T17:48:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef2671c-48a2-435f-9424-08d9583bf890
x-ms-traffictypediagnostic: CO1PR21MB1300:
x-microsoft-antispam-prvs: <CO1PR21MB1300CE10FCC17FFDDD2767A5D7F29@CO1PR21MB1300.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPp8Xcevg2gUuAXQy5aLVpImZ/WsmZBOg6WZ4V9JJh1jUbirafocTRAn8kn/ZsklL5oHDYZEfh5BucnO4QXypiEqByj3RD2DVnucNAgsvjFMPuJDu7/SgiypAJPyq15YCW73UH6T0fkfJfYF7pmHz5YgN3Q9lS2h+K4J5/33mKDQCJvjSkgWAz8LSx5BJoNafJw+SGm9pk8/E07pqXQMf9fgC/VyoADR6mmmbMSyg6x7weblucHlfZJtepE4SGvmYT9EEqOk8dq+eoMOxEN9hJrSLjwgMnW8Wlxa8IMZbqUB8lCbn+v8qsmTYGdaaipYDDKpYzAh/woJNop7uKI5mlRp2WYAhimlJHBzqB67rqbuC3YaiQe9ze4K0SufLTXHaTkz3/ppHLysWBrv3sQ4RO4TQn+85Y59E61S20DHDJ1sdKvOuSSXUAziamQI94PRNaVG2Y6Q710SnoqzKb5W/gtK2Rc7opt1b+NtblbEdSyG+Jpnua8Pt23iDogm0GeaSRMtmrhTUj7vpdFgv0nUWLoADU5gz1EoX9twh1iHI5GE8DY+bX/ve4uecB+acUC26PvmVqgnFMJ4VsJGXaHA7OqVvPdFFwvhBytxUrf4vLV/iB40oh6CjM8zTGOxEQ4pQW/iQ8WXF4lktc4bOf6hyM62zIDsJQvnj2vgKJRdpI+FVGmfe7SIf3Wlj3v8CgObZo2ehX6alZbzyGM/lr5nZQVV2T2zDR3oS8eJVb9CRAA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(55016002)(86362001)(6506007)(82960400001)(110136005)(9686003)(38070700005)(186003)(82950400001)(26005)(8676002)(66446008)(33656002)(10290500003)(508600001)(122000001)(52536014)(66946007)(64756008)(2906002)(76116006)(8990500004)(83380400001)(66476007)(7696005)(66556008)(38100700002)(71200400001)(316002)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GeWBlJGuVNd9+9DSLqUj5G4HbUv0+XWiYrD3xD0RHSpw/EQxN2C3/Llg34nc?=
 =?us-ascii?Q?4fgg8W/UCR3WkD21sCR2lUDILul16u52PVO5vLeaG3YFyh1/z/bdggC57t/x?=
 =?us-ascii?Q?1VU/2p79wWbiks94T/snMj0AX8p+2IVhER+LJjD9knae9LhSGio0DwForgzp?=
 =?us-ascii?Q?X2BU4V4+NVM4g7S6NRe+ldHYRasoFkdJF4Xh7yKcYcAwskAHf55DBp26T0i5?=
 =?us-ascii?Q?MixvMpcE3MpR0rLgbuYr9CYEOdENrhQgwDFD6xoGQM/BWwOqtRTSH//WiVvS?=
 =?us-ascii?Q?OFQVl99Qevw0kk24NUi2j8UUSOLPAa9jbAY2BBNtq3ziK494Ooq64XkbTI+B?=
 =?us-ascii?Q?0gCqc+mw8J3rS3N2WUYbETocbZmSDYfXhBDzPCnvIoiAO3OAC48AjdB90RO+?=
 =?us-ascii?Q?FGbNwWpPZ41aX+jbg8yuKBHCLsDqrB7YvXmGq8wVsfz2pIRpi/HL2nUEH17T?=
 =?us-ascii?Q?6PH5S/Z9rq29QXmGyKwgIIk5dE3ckCC4YY/ni3JCIfRGmjAvQ1nL1AnO/yIB?=
 =?us-ascii?Q?48uYxqXy9icpuwIciEU55Nb3nqcJEh7Z82/s2so7SkH4PX9Cz04AIFnmJDK2?=
 =?us-ascii?Q?ZX5EQ9PMWsIJy59YHFeRhULa+CaMt5Rmb4yu7zhSV7ciYCk739SHhpyNHgvt?=
 =?us-ascii?Q?3OJGdGhaA3KjQEOCfUNOcRnPVNkD2dxkPsGpmEVEEvD3dlxBULbmhxnp8vq7?=
 =?us-ascii?Q?5aiXXjJ/csGaSONoYDVleD4eZJPQRtc1q7+AjD3jCtuErnoCBikeQtZEF1Zp?=
 =?us-ascii?Q?Mx3eoGqw+yDSypejeaSetmPFyAB990AwEhfaWI/cMT+6PC0h2Gw8+LhwhakV?=
 =?us-ascii?Q?cc1ZTFu8NbJHPlEieokbkpZGjNxv0/Pz3oNhZll0IKgGqPZ0HAviS8RZ+FZB?=
 =?us-ascii?Q?d1Hvn6zsK/OxX4vgc0rQLFdHhJjB98fknBjwfRJJRsMylpVIZOJJh+dOO7zq?=
 =?us-ascii?Q?UuxZZETqCI77SaBbK5RdjIp+a6CPRLDDV5x033AZHqOUxH9vkoA9fIEElKUV?=
 =?us-ascii?Q?kptTVMYSnWhKhxs8xPfpVgHOZveqbdaYBwtEn7/5uiTwlBo+TFpfujM+fjIK?=
 =?us-ascii?Q?d8juFTtt0J1Opdt9WymgS6q0xEa4Dc/Gg3zUAwmJtF8iNp1uewo4PBNqGiSk?=
 =?us-ascii?Q?DCyl3hKxqgw9tWdu8W3UDHGP+L+Swnpmr7l1kU4D80cTOaIwPgJTggGLFJj3?=
 =?us-ascii?Q?0SaVM+z1qYp/8ywh+8dynBL+tQCmzwyjcAk7Y3p+YrIKS+g7AJ+dUdOJf430?=
 =?us-ascii?Q?/SdRsNcD0QcDiQDSvkHjeeRlBvMN27vwrsQJ26OtB/fOSh2ZvaNMvKPab3SE?=
 =?us-ascii?Q?vFgRBo7akue3OufX/Ts5b7Tn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef2671c-48a2-435f-9424-08d9583bf890
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 18:08:04.4646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TuZdrnD9dV9rkS8tV1uFnP0Js4bTW4xyQ37hg5qckhtnxvmXUdmX3mskJjvynVQkJOcV0sBeUbdAqGR+D7pb5AKy0AlWr/0FhSeyq6YWqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1300
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: David Mozes <david.mozes@silk.us>
>=20
> Hi,
> The problem is happening to me very frequently on kernel 4.19.195
>=20

David -- could you give us a little more context?   Were you running earlie=
r
4.19.xxx versions and did not see this problem?   There was a timing
problem in  hyperv_flush_tlb_others() that was fixed in early January
2021.  The fix was backported to the 4.19 longterm tree, and should
be included in 4.19.195.  Outside of that, I'm not aware of a problem
in this area.

For completeness, what version of Hyper-V are you using?  And how
many vCPUs in your VM?

Michael

>=20
>=20
> ug  4 03:59:01 c-node04 kernel: [36976.388554] BUG: KASAN: slab-out-of-bo=
unds in hyperv_flush_tlb_others+0xec9/0x1640
> Aug  4 03:59:01 c-node04 kernel: [36976.388556] Read of size 4 at addr ff=
ff889e5e127440 by task ps/52478
> Aug  4 03:59:01 c-node04 kernel: [36976.388556]
> Aug  4 03:59:01 c-node04 kernel: [36976.388560] CPU: 4 PID: 52478 Comm: p=
s Kdump: loaded Tainted: G        W  OE
> 4.19.195-KM9 #1
> Aug  4 03:59:01 c-node04 kernel: [36976.388562] Hardware name: Microsoft =
Corporation Virtual Machine/Virtual Machine,
> BIOS 090008  12/07/2018
> Aug  4 03:59:01 c-node04 kernel: [36976.388562] Call Trace:
> Aug  4 03:59:01 c-node04 kernel: [36976.388569]  dump_stack+0x11d/0x1a7
> Aug  4 03:59:01 c-node04 kernel: [36976.388572]  ? dump_stack_print_info.=
cold.0+0x1b/0x1b
> Aug  4 03:59:01 c-node04 kernel: [36976.388576]  ? percpu_ref_tryget_live=
+0x2f0/0x2f0
> Aug  4 03:59:01 c-node04 kernel: [36976.388580]  ? rb_erase_cached+0xc4c/=
0x2880
> Aug  4 03:59:01 c-node04 kernel: [36976.388584]  ? printk+0x9f/0xc5
> Aug  4 03:59:01 c-node04 kernel: [36976.388585]  ? snapshot_ioctl.cold.1+=
0x74/0x74
> Aug  4 03:59:01 c-node04 kernel: [36976.388590]  print_address_descriptio=
n+0x65/0x22e
> Aug  4 03:59:01 c-node04 kernel: [36976.388592]  kasan_report.cold.6+0x24=
3/0x2ff
> Aug  4 03:59:01 c-node04 kernel: [36976.388594]  ? hyperv_flush_tlb_other=
s+0xec9/0x1640
> Aug  4 03:59:01 c-node04 kernel: [36976.388596]  hyperv_flush_tlb_others+=
0xec9/0x1640
> Aug  4 03:59:01 c-node04 kernel: [36976.388601]  ?
> trace_event_raw_event_hyperv_nested_flush_guest_mapping+0x1b0/0x1b0
> Aug  4 03:59:01 c-node04 kernel: [36976.388603]  ? mem_cgroup_try_charge+=
0x3cc/0x7d0
> Aug  4 03:59:01 c-node04 kernel: [36976.388608]  flush_tlb_mm_range+0x25c=
/0x370
> Aug  4 03:59:01 c-node04 kernel: [36976.388611]  ? native_flush_tlb_other=
s+0x3b0/0x3b0
> Aug  4 03:59:01 c-node04 kernel: [36976.388616]  ptep_clear_flush+0x192/0=
x1d0
> Aug  4 03:59:01 c-node04 kernel: [36976.388618]  ? pmd_clear_bad+0x70/0x7=
0
> Aug  4 03:59:01 c-node04 kernel: [36976.388622]  wp_page_copy+0x861/0x1a3=
0
> Aug  4 03:59:01 c-node04 kernel: [36976.388624]  ? follow_pfn+0x2f0/0x2f0
> Aug  4 03:59:01 c-node04 kernel: [36976.388627]  ? active_load_balance_cp=
u_stop+0x10d0/0x10d0
> Aug  4 03:59:01 c-node04 kernel: [36976.388632]  ? get_page_from_freelist=
+0x330c/0x4660
> Aug  4 03:59:01 c-node04 kernel: [36976.388638]  ? activate_page+0x660/0x=
660
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? rb_erase+0x2a40/0x2a40
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? wake_up_page_bit+0x4d0=
/0x4d0
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? unwind_next_frame+0x11=
3e/0x1920
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __pte_alloc_kernel+0x3=
50/0x350
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? deref_stack_reg+0x130/=
0x130
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  do_wp_page+0x461/0x1ca0
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? deref_stack_reg+0x130/=
0x130
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? finish_mkwrite_fault+0=
x710/0x710
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? unwind_next_frame+0x10=
5d/0x1920
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? entry_SYSCALL_64_after=
_hwframe+0x44/0xa9
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __pte_alloc_kernel+0x3=
50/0x350
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __zone_watermark_ok+0x=
33c/0x640
> Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? _raw_spin_lock+0x13/0x=
30
> Pattern not found  (press RETURN)
