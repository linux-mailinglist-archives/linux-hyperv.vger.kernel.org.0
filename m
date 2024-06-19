Return-Path: <linux-hyperv+bounces-2451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3890E118
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2024 03:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B7C2856C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Jun 2024 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31714C74;
	Wed, 19 Jun 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LYsXC93c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A0AD24;
	Wed, 19 Jun 2024 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718758981; cv=fail; b=VDM81Hnde2x7t6qMqEnahHUAzMSZigHIbZAGca+l/Is65TKa2yYUkAXLfCDi5+GJgpn5EkkS3zLUs8meIk59TJESvEkt78UcrnIIizH/NenEjLxpTlpoez4yxQrpqqPk/3FVhwIL4KQj8C2HUF3nGM+VMzCl+sF3pM7ZMaHId8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718758981; c=relaxed/simple;
	bh=wK3uJlMTx5Zhq02vz1iiTDig8BP3PKg3pJFNJsgELCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aImiy92JnU7zbT+mi/XtXt19TlqlyVd0VTHmjOYwILXAtFd0FZCOFPdMFS5PQ16q3xt4NbdYNUCKg5pKayJ0oL8Inlun43/NIEFVK2+cYVMkffGrSEyA4dKlC08IckUAEbFay5NIW8Jl/35gUKem+AdTzu3GjgsOUNCR+5cA/SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LYsXC93c; arc=fail smtp.client-ip=40.107.223.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVfLrBpL7mUfUJfQDrk2HLvM9LRrbzIOhnUO7SR65nhJdv6rI+sOPybdzgtORm2/ueCUXX+5ul1yAYASH2koxkmFyxAimWevJr+bY7bemxqaLsw0hq3fJ6Mq8CvQo3mXsUcIXHP0BOJSrlQj14bBZyknxCaUU0GxoL6Qpzk4q6rxXfVtFpHuk2tgnVP9/R+5WhAg3UfxgOogArY0k3yNPl3scQQb3Bo2bYAywkgT0csWMJB0k58BeOLF1VAXFsFs/EGZIo2kWil/s0+cPAaCXJPiOa4/nNaGJ5ynqc2V7u3PuBpTGldaBBMgl4O3IBaPghlwErfyCVcSAnBNjjSWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGGFuFVYKJue3QNYZtLzJVrvUo3ZgjPvdg6ISpL3zfs=;
 b=FATaOOA0JvmnQtrc7zg3tDjeYI3K6PSrLNaz9lw4G1SjSKW/qC1zON815mEAZeJy14d68NsgNpTYFzgUtj3xbaISDUuJjzHvvIy89ZtWUkydCR/iA5m+lY0RbZrd+ip0zTe5J3o3lO2LDx5qNKPNDjzTfT9X+qMP6y+ZkE4e9CCUjg/Zo+/cf0UYVyKmDZGmuAYhcAW9hce7+WDI/c+eSYqhOGKEurHWdB82fo1pp7tuNsE4UqB9l9GSbai5M7EMK7NXgys8WGSJaRmmJwCqLOCOAnFcqnNHs+A51BzJP8T75c6FPlD8+2TEZICFpN9cjRi3t5/vXIpJnR7pU+ZGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGGFuFVYKJue3QNYZtLzJVrvUo3ZgjPvdg6ISpL3zfs=;
 b=LYsXC93cmmP3DN1b3zx67psAmQwzga/hpCxShHZUfVl4MeSYdXxRH6kZubBLNFHXY0gIvJMFcRldKlvyhYfxJT+2353s6jHtnlWhZ8qdFbo6/sDicoeV2Uy0tUOgVcEPJgDY5mf6DryPXFpqifX2Hy17IKIzfBeDMgAb9cULsaU=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by IA1PR21MB3714.namprd21.prod.outlook.com (2603:10b6:208:3e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.9; Wed, 19 Jun
 2024 01:02:56 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7698.007; Wed, 19 Jun 2024
 01:02:56 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"brijesh.singh@amd.com" <brijesh.singh@amd.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.hansen@intel.com" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jane.chu@oracle.com" <jane.chu@oracle.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, KY
 Srinivasan <kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, jason <jason@zx2c4.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, mhklinux <mhklinux@outlook.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, Anthony Davis <andavis@redhat.com>, Mark Heslin
	<mheslin@redhat.com>, vkuznets <vkuznets@redhat.com>, "xiaoyao.li@intel.com"
	<xiaoyao.li@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Topic: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Index: AQHaqyRyOklGqBX1uUS+MuWAg/1bsbHOcS1w
Date: Wed, 19 Jun 2024 01:02:56 +0000
Message-ID:
 <SA1PR21MB13178F8084705F3D2908E03ABFCF2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240521021238.1803-1-decui@microsoft.com>
In-Reply-To: <20240521021238.1803-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cddf0a1f-9dad-44b1-bd9d-5200968d5b75;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-19T00:58:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|IA1PR21MB3714:EE_
x-ms-office365-filtering-correlation-id: 12d886d8-3db6-40b2-ebcd-08dc8ffb8df7
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|366013|1800799021|38070700015|921017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?S/eB8C2iMwQ1qENUDd7goHHX+7VaFuRBulC4OkQHO3mK42lHIlj3OsDWg+tC?=
 =?us-ascii?Q?mb0PNwIQj/BREM6wumotoAidhQLsHOCBeEpVKK6XivsQV8iTaQV2hr2nTXBc?=
 =?us-ascii?Q?ljLAyXJb8r4WvRR+/Ql2D8PwfLGGK6zvbQ8rszE7VtC+1LXm16BvhN76yxDG?=
 =?us-ascii?Q?AVQJTCHlfAdkv9qHBiJ/SyRbEb3OEdMlQsdEiBTRPYr5fW0F1uAJsGUbyuQ2?=
 =?us-ascii?Q?JZNsMDqk9u2Jjsii9OvqwZOrwozvldUOyXlUDwDGmqkO5FvrD7ilDKGGnHJC?=
 =?us-ascii?Q?H9LKb+uZ6j+VAefrKW9vcbi0Vt3Dj8Zjtk1you6rjBhTYv73Xyp+blhRMuMG?=
 =?us-ascii?Q?IGyGGYwEIycK0CY2Son7cT+jRZcJyhKqmtGrM69wAfHk7rKWmI8a4bchgELe?=
 =?us-ascii?Q?DV/UMQqpkLMqYiautjQz+ccqCYhzqIjQja+2rMs6+cWAA9wruo1NgtvUap0u?=
 =?us-ascii?Q?NPb6TWTVJRcfkUujWxapT9ZgUJEorqRgu1/3jRjYtatyrQWtWJ5/ACHrZVKW?=
 =?us-ascii?Q?tubwgzZb8zYwwxLcQB8jLRkhFoLdpoeGRbr7ikVrlVi8fFq8uySt3CJJyJAa?=
 =?us-ascii?Q?THMozx76R4b0/OJv6k1vNyZeNjtxxGeLEqX09drPu9thZfW4MYgDk1+korzM?=
 =?us-ascii?Q?fVDohS6anRuzPvqZzBDhpzVxKz0E5TaxrnjHfgTiPAzMyuaM2u3q5lkbZ+Al?=
 =?us-ascii?Q?L7TIrTy1xnOszrkkvVwXkM2Y/R7WeBqkb+1ZW9az7Birofndd1eyymeQ247M?=
 =?us-ascii?Q?nBDzgnAxWdjdHigwfZPpgiohF5xwlJqpRKnyzLD780bpJYDwzNxYccE1akHE?=
 =?us-ascii?Q?A4MEiV2mxtwEl+V+U7gATUvcHJlfScbUM0Bux3/2oP5S2xVjkpbDh+Ujaln2?=
 =?us-ascii?Q?XJcoAEKJTHjKuVK2lPxuL7Yi+zZnUhsPNTOSRwPUXgBzP6R2hVOYC7LyODAF?=
 =?us-ascii?Q?CJbnu5ngZ4MTR2K27OQfrHBUNQAm6Z4QO9V9998b7kAhqC0CIb8PAuj/gJvS?=
 =?us-ascii?Q?Zff7qqcGMdCjJuSE1cQ5xRLBVGPt0I0Yiwh27BLzi/fjfcGscM2//1PiB2GR?=
 =?us-ascii?Q?+6LaQkxArYt443gRmYhevhKrL0/VcBjfvpI7aJBUolAbCYO/FzpRjIICw9wM?=
 =?us-ascii?Q?yCMzqeutKEs4EifnEFOooINO71zFSIg2TDPaNKb6myKgOE2U/0FebIjAZG+2?=
 =?us-ascii?Q?4KtVdPd6dMT/ttzN2WgJsr3jnR7JSGv5NVGGtsxl93EYsqlpstX7V5bfE7vS?=
 =?us-ascii?Q?ZiWaQZrW2vWtpkXpk8xXUyxcVtznbDgOc6pWacyD91JztBn45rVLjyobQILg?=
 =?us-ascii?Q?oHS3s1wiTRFrkXLUMFUfktTdhMWfDwGQns7EuXBp8j6U1Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021)(38070700015)(921017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?l4x3ByhIeDkN3igqB8Fz+hP9HkkTwamtKVD673PwsMRsDz51YA90ke/Zjbuv?=
 =?us-ascii?Q?7CqQJQZjH9oNJSVssuuvXkEPU/gs/yaVEI0Bs95mIbSK1HUPlWQh6gxXsXmx?=
 =?us-ascii?Q?lMxI9FqSK4W9rZ9E2jAazPOTSKL9CxGfSS7D8RFSv/es5cJBkkyL1KT9i0Xx?=
 =?us-ascii?Q?SYoWx/BlyrOIWLcGd08B006/Q/o34NBoUFkpEeHj+AhoDaIj84qRCS4ALYoj?=
 =?us-ascii?Q?HfGKJkeofr7oJHSmLd785DRU4gQiglAbdcEUBLgbujErNvv/TW/DxdN8yFGs?=
 =?us-ascii?Q?kDXS8PFInSkkW+vU720dvJzDHjzoiPFFJ08f+9AXxdWuvjeIRaXHIiYO7QkP?=
 =?us-ascii?Q?S7d+exQNJtLTBXIRdUvCgCIPloQYAM9Cl4vHAwy85HxMYxAb5ygf1bQlTi0u?=
 =?us-ascii?Q?1xGriJbQOyHpICkvMXEWisfUcDMTi6bZEXY1MQ9j4A04p970+8bWgfxO/4G0?=
 =?us-ascii?Q?Koz+0pGKU7KvMvoDawliYcvqs3UXbmlXXjLkQv3HxyJWwP+7XJYflswd2Uxb?=
 =?us-ascii?Q?oVkmqhh0lW10X5l97DRZ1zJ1OviF3ym9b8pyYUyhbyn62clYiyB7KKp208eS?=
 =?us-ascii?Q?I8fASf+yOKvPJ9Zk+tdyhQ5GdeGfaEEy/Up4Kra82j1LC/spxti3trH6T/yM?=
 =?us-ascii?Q?qtxtoBrOkYk2l6YKm/NzRppJ1bBsHqALpe8BZuMcoNY+2g2hVPBENd4W/7G5?=
 =?us-ascii?Q?nyVL5FieG1HYYpFOelkEfdJ0pTcEagramwMar0vfFBTh2e808n9iBV52nKAt?=
 =?us-ascii?Q?U/RGYVr6GCoIy06yOLNzpQ4eY6PCDe/Qq597c01bS99XBcv76DFCDfZH2zXe?=
 =?us-ascii?Q?M3ohorH4VFKyiSNGHQqLh3tPrDlajBTOjw3LU8MZIbu8uoNJ73d3algQnfZZ?=
 =?us-ascii?Q?g4z6muXFIZRYL1geX+G9kdNoXm8bjL8gE9lSrfQpLdiGS7ASgtEsKvDj0GPR?=
 =?us-ascii?Q?NslhBYLYG+VOP+TzxQ6bZYtDlkbucRbhpxrILPgAHzNquvOFni3x6pboSOr0?=
 =?us-ascii?Q?zeEpxtF1s6tNHL24TONzX05yenUu1TPrXDPm++ERvDO0dYwReeOiSUq7UfEw?=
 =?us-ascii?Q?i9Pmz7MAMtIhgcxytBoIG3QZBu+7HhEqbGmkXhrqgufI8J1JU+pkjYCRDd8F?=
 =?us-ascii?Q?qGvF3SlZJOiBXkQVqY0H2evI8A+vnJQevpAl3JkBH0mGx33hBFYW4kpSvR1b?=
 =?us-ascii?Q?GgnOhO/y9q0+OnR8wYbxqWXbqdB2HXfa4y/1d5AdRd7Oj6hUPjj97tKp5zp0?=
 =?us-ascii?Q?8acpjXCvUaIVPBz9gupk/ZR1AdfOqX19Bl5icsk7RWKrI+CUstBox1/RbVjg?=
 =?us-ascii?Q?/Y5BEWpKY652T8AW3MxthUnIwWIq0oOfbQaFtiYaPhsllWHZMN9jmb41rY0Q?=
 =?us-ascii?Q?EJ0lDJ+p5hwuBfa0en3Prj590P1clnjngvnAbpCvlsVBsfZRIBe+Xnk7oFEC?=
 =?us-ascii?Q?xHp/6N2PdKNVhJ0sk6+6nANJEs9gqxno+6gAv2TptIS9ctkywcvcwFUXqKtF?=
 =?us-ascii?Q?+Jc4kBCTi8UOetmw6SDWb+90hVPnBQOfRvq2sWRI4pfJHUzrMvti/YqjaH8U?=
 =?us-ascii?Q?sPAGkwzN6CaJmodA2Cc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d886d8-3db6-40b2-ebcd-08dc8ffb8df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 01:02:56.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHndreYTnlPIF3DTrxI3PA5w9WaXWWQkVyX4uSPakN+MkKEki1OcWb2KxpshNvN/2GP8vNiX1KbeDia5iiAMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3714

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, May 20, 2024 7:13 PM
> [....]
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's
> netvsc_init_buf()
> allocates buffers using vzalloc(), and needs to share the buffers with th=
e
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.
>=20
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Cc: stable@vger.kernel.org # 6.6+
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This is basically a repost of the second patch of the 2023 patchset:
> https://lwn.net/ml/linux-kernel/20230811214826.9609-3-decui@microsoft.com=
/
>=20
> The first patch of the patchset got merged into mainline, but unluckily t=
he
> second patch didn't, and I kind of lost track of it. Sorry.
>=20
> Changes since the previous patchset (please refer to the link above):
>   Added Rick's and Dave's Reviewed-by.
>   Added Kai's Acked-by.
>   Removeda the test "if (offset_in_page(start) !=3D 0)" since we know the
>   'start' is page-aligned: see __set_memory_enc_pgtable().
>=20
> Please review. Thanks!
> Dexuan

The patch still applies cleanly to 6.10-rc4.

A gentle ping.

