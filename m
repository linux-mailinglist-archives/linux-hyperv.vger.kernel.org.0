Return-Path: <linux-hyperv+bounces-2506-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17791C683
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 21:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D4A282CE6
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942A86F2E3;
	Fri, 28 Jun 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iVU9AUP/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2121.outbound.protection.outlook.com [40.107.237.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC7757ED;
	Fri, 28 Jun 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602661; cv=fail; b=M7gd4HztUkWo47AeXeSRrpRXn2rguKC6J2lN9w53y7oB4qFC4OMKdAZFR7JVzBX2DbUuZvqSyfxt7cvN6IPmOib4Ir/kldYHdpY5M9HYstN8vW4jVzlXkEIQA7xJNdGDxd4z2nc6XKbHMyDLTpllOmNlUsq99rc6wtOI8yuk7XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602661; c=relaxed/simple;
	bh=DxNR2BtOTGu0C2nEPiUFOr0tkVxbkqyzQo/ve0gqxU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H97IVkiEnMVUk2M7cWYHz3aEpahcVj3oNa7L7uP7xiKBFMqqEP+eqtIbWpd/+vg2jPhYNtByUprPXxqCqicQD4+71ExTOCrOJs+13GaA4jQXqxw1gM853lgdRxzuwQYUwiJuxv4xhqON4/8OYea4NEMLKX1jc1eUrujXtSVqs74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=iVU9AUP/; arc=fail smtp.client-ip=40.107.237.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY1g99Imvf7t/WawFsN8IruXoCYvffdqZClvbaO/utjLQmto51kuFzUQ9Dl3hp+TyZx68p989B2oRmM4pBzlMpqHr1rmswuNZ346OE7914iE0FBYqQFnJ6t7wIiyRyUuHVVJhFsjHGGdwOGI2FyHJHECoIaPaUmkL4j6LJabN9BDqvHGW1faDbcrvKupi5bW0pUzGsey1oeQHDbJ/Kb96Y6sDoII7tOB08i0Iw1ZNsmp8po2vinrsd73Kl7cRsP6PerxHE5l0xdY15VDXJjStEqT5IOiJzRBrCjuwwSLSZkJC09A2QDBxgBSRkV08VacNgiCLyJVsMBeH1WuYgFTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRlcpEkbGgMuozS3fnv0l0jWPScGySlscaa37CobGQ8=;
 b=b9k2J4Mp8PcAY3ByauEWlR+Ol5klURrl4VfpoHuKv1lzLbw5ahHB+iEEA8fcbVpWmn+LA9ghERMn6fUD+aBWXVcHZp6y7voHmlJVg2OPhnKrNxoR/LoaOIYqfhUm7G9pi5Epcjx/Tw6eNUDTJkMW2Vuh6tosFm0QZ628h4fzcphSfW7pDIZpw7EIvJFDx0FYjPu1EGev4GXnl5qpIOY38OsHKdgtUK+ZX0Nu7UdV49TnNf8u/3Nd3fRcK3uYsxtQ9JiMCLCwh9AYlEK8NzDdoXs6gexqHVRykVYqNvg6fRyQ4FAydLXJMY+UgHDJcuEeuZlTyvUUAzIG5RzWjEy9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRlcpEkbGgMuozS3fnv0l0jWPScGySlscaa37CobGQ8=;
 b=iVU9AUP/9a70puIb4BJMs4qLVa2x/+ZZhRhXdfZKtddSAF/GZbM1dP1h3+rutjhj3QzkVeGzudBneDLpJSFa8gg5Rw839PyGiwd4rl5J0jDwtu8yAnsWq0+VzYLnQhRcmYRiMgZl3/LGOGeyYW2Qj9wHhyrc3H2G5c1H3UWJGWc=
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com (2603:10b6:a03:3f0::13)
 by PH8PR21MB3958.namprd21.prod.outlook.com (2603:10b6:510:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.5; Fri, 28 Jun
 2024 19:24:10 +0000
Received: from SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::8e3d:b3cf:b887:677c]) by SJ0PR21MB1324.namprd21.prod.outlook.com
 ([fe80::8e3d:b3cf:b887:677c%4]) with mapi id 15.20.7741.001; Fri, 28 Jun 2024
 19:24:10 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
	"brijesh.singh@amd.com" <brijesh.singh@amd.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.hansen@intel.com" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"jane.chu@oracle.com" <jane.chu@oracle.com>, KY Srinivasan
	<kys@microsoft.com>, "luto@kernel.org" <luto@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, jason <jason@zx2c4.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, mhklinux <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tianyu Lan
	<Tianyu.Lan@microsoft.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "andavis@redhat.com" <andavis@redhat.com>, Mark
 Heslin <mheslin@redhat.com>, vkuznets <vkuznets@redhat.com>,
	"xiaoyao.li@intel.com" <xiaoyao.li@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Topic: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Index: AQHayUKVOklGqBX1uUS+MuWAg/1bsbHdjdhQ
Date: Fri, 28 Jun 2024 19:24:10 +0000
Message-ID:
 <SJ0PR21MB1324C3F886F318C3A3561792BFD02@SJ0PR21MB1324.namprd21.prod.outlook.com>
References: <20240521021238.1803-1-decui@microsoft.com>
 <kjt2m2aqnhmwqgn3ox6bkqtn5qurxawgnx3xyh42pu5sp3mwyj@qwyjttwubfck>
In-Reply-To: <kjt2m2aqnhmwqgn3ox6bkqtn5qurxawgnx3xyh42pu5sp3mwyj@qwyjttwubfck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07638070-77bb-4d6e-8330-611deb8dad8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-28T19:20:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR21MB1324:EE_|PH8PR21MB3958:EE_
x-ms-office365-filtering-correlation-id: 2f148566-3e49-415c-c0b4-08dc97a7e2de
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hsohBQhIqb58y6k33Hq3kUY3YdYVuQWChXABubxk6H1omQdE1sH6ZCKh25ML?=
 =?us-ascii?Q?JH7zC9IlfZeMFpBO+YuJhbZTC2mUx4vKoGRATWr0wkQ3TmmFMJ3UwWUu5YXc?=
 =?us-ascii?Q?2+ekdW2AtPcjdn9JC718gS84wruHi5KDViTlKSUZXjrQeaL4ssBzj3uCz1kG?=
 =?us-ascii?Q?ARtSAzt5ELxnzEnIR/ed/Pj2B5lnAEHpZEcpxORO8IbtWoWXjX9claqcB3K1?=
 =?us-ascii?Q?eK+4vSIx5tHIaObo0idiP21jmoNQetqJPLRJOq2TlYiFDhdKFBIZGUUgUvmy?=
 =?us-ascii?Q?F1vHU8akasrIqXuOjoxLny/2YTilgSmdAFrL5hX18e7h5USDy4gdgGLkhhJD?=
 =?us-ascii?Q?b8t71Sx4qr9Q1Si8t5nVYpIX63RFzA1VccQAoa1/gd4Lg7nhdPEnooa10GxU?=
 =?us-ascii?Q?giql4679PfLHZFmWRHuDqp3bODIl5D0Zq0b6zP3Rwyh6jLjlxOPbhj/iyjiY?=
 =?us-ascii?Q?QyXSb+YKi5hUgHg7C0K/lG46HTwV5U9r/XJvE5mrDaeu8xZuodGbyiTbQxYa?=
 =?us-ascii?Q?k/e2xh12HgMJ/LC+LH4zJ1DVzzRS2Jwl6I7q238D6VuQSKvaNgORVklziJSC?=
 =?us-ascii?Q?WGyNei882HVTVJNmKcep33g+nZBsjZmdhitp2EqPRncDAojB60QsHZ3YjjHL?=
 =?us-ascii?Q?wp9DKlBe3CsoxjMVhN1Yxg7qUyMPHo9A7vwVBkBbJF/Bx+aBY8wuLxVBBhQN?=
 =?us-ascii?Q?RuuWRyZJBod2ko7Lij+tdUCepRKQ4TYvWFOXtTGbMIMBqx0CaiQMZZNStI+L?=
 =?us-ascii?Q?5HXQ+v90KRX3rrAdVOhEQMaCmmigbbA8B/f6wdVJt3T65nipTk5Cpo47Jd79?=
 =?us-ascii?Q?GevWOagSvjWngSsJeQudCjKlWC4iR7W1xciukQkKTE7X+OvSSZVoptVAGFzO?=
 =?us-ascii?Q?uPoc8vs8cflTffD9y7hwH5Hhsh5p20kQXbkWKWHiojq12pf2OrfsXCjvp9Td?=
 =?us-ascii?Q?xfUeMlOWJyvotO4jOaSMDofatN/1/1MPUus7vLjbM/Q2T9uyJaUPlpo00SFs?=
 =?us-ascii?Q?RrPgZPCURAHkGKARkF3cODaHRA3TDAPQwqO3yJ/G7QHbH99ftwhcWlb//UE/?=
 =?us-ascii?Q?iwlXDlSeweInfOArxRzRn3r65WsNQisOyZvKsfaXQB4VWDsBVTcFbovX6BxP?=
 =?us-ascii?Q?Y0dqsYi+YEwrqWERAmTwLqILEnA81O8LDkjuTCVB/alJhzZKGFIDWUHAqIHB?=
 =?us-ascii?Q?BA0FdVTr1FZQJMLokDFnezZD/FEcfDgjatVjlhzIxxRXyJ3ldqezAUklMbob?=
 =?us-ascii?Q?R+Il70Dc11f6H3J5dVNkw837Xare+Kc1bi4JPAF/NcjP4c+6RDpUUth+8BTS?=
 =?us-ascii?Q?5wZC8yUW/TrgXP5nBgteUUf0gFfEssq7vemh4Xnh3RY9hY4QeqaTVPmjJ2ds?=
 =?us-ascii?Q?oQCmFTvDgx/YuqzroUoaYS6x95Nm26Zj8n+ihUQ5WEUw8t7RxA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR21MB1324.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hxCg8YUDZh+vAQGK1XjnLgmcI+lIGljQOcM5koMJ79v5dNi+d8/mjOSSAKo/?=
 =?us-ascii?Q?La8Mhw2YquaMmCPDFwvEK4XBCcW3TtV4EaQ2o+Lr8y7T9yw4zjeTefuMkZtv?=
 =?us-ascii?Q?7iMaNGXFwqUp/RvMBZbG9dUS0N5uG0umnzsBqP2uTxUnfvh/ZHi8ThmKtIeB?=
 =?us-ascii?Q?v4QAV+jq+qhuhsYneOKK8w7MzFbFUnUA3k055Arx1xqf9pt0CKGOa0+pMYut?=
 =?us-ascii?Q?+LcAfPikp1CPTfdJF4lA9WoW4uHdOuUK74fhicv0NGWh1qukr4JQPsKKRebx?=
 =?us-ascii?Q?znL70RQSbs34NSgpadG993nrQaTZppar4GLNEtbxYRPioAsXDLHrRN3LZnZF?=
 =?us-ascii?Q?M4B79zE0fXHWqu9MPLSeSiZSlGPBDH2wMmfHiDxtJaOzAxzh4NR+8wsgnuG6?=
 =?us-ascii?Q?Nq3ZIutRjNU4PQt2Yhaw3D3wXhypFvdEWTjZo8hV6vhSmoXAccI6DjyEdtcR?=
 =?us-ascii?Q?WvVvWsvafeUafBZBGXuAXjIL7TdRB3k7vTyRzOyZe1BNdm32lzmLPVVmMHEb?=
 =?us-ascii?Q?2n+Gc8ibIN+GFikw/sClBmR7rLJiLFoDnP+65Zp+ihQCA1CLXEAUfvCOqNYn?=
 =?us-ascii?Q?M78CEMlKIyeiyCXcTTmIaGEt05qMpNIPOkpubSVubf676Y4nUY3B3GIenX8X?=
 =?us-ascii?Q?kHnpcMGHHQdr5w9rC+DlUDbpM5y72CGXylIIdiyAj9t1MQwVnRD8D0Ffv5nA?=
 =?us-ascii?Q?MCabzj7Q4zYx2DszR82YYhOg/W3ljATZn0nPlwplK+mc8ZzXJr5Mxle4v0BL?=
 =?us-ascii?Q?9HkbsrU2XTdPGzTing1eKMDJaPvTmTPpwS0SCce8hzJR7oqO47RjPxi6N9s3?=
 =?us-ascii?Q?Kx34pToJSbqEPJdSpCTx9gYTBOFVXPxztrKmFLZloV24HJK1poxMNHX/QuM3?=
 =?us-ascii?Q?Vp1EKvclTkS3wqgodfAekkKP2AA9nChwglzg3uqMcEpglEipUmaySrbccu7V?=
 =?us-ascii?Q?tp8dP3aXua0JDFypMh130H1nCXFbYMMnr12cNkAbFUGbuYkOXno7AqckKAmn?=
 =?us-ascii?Q?DpuBUWJ0oZA7Xn1/vpB3gcKuqjvJnBltrkENVL8bVVyG+oGHxKC1uMIJvxAL?=
 =?us-ascii?Q?HK1B4Z7eBLopaDj9T887tmT+83Ey5Jhx6hxBA2Y2Lw81Fz9WNXNjqEY5PxiY?=
 =?us-ascii?Q?eymehVUcJ1kHy5PNvKyZap4J1wDJGScul4i6yTcigRolSRrJws4xouk8aL8k?=
 =?us-ascii?Q?bWRZxb/8MSr1Tr52PPxoXIQh978TsLskB7e7tdYBU2sJQHPihzfxhD5qSi2R?=
 =?us-ascii?Q?qAhz6ec0lozRwH9LXAB8dfQ/g/ydPNtLqecwuiF59CNWSDyEPdJl1ClfNEgl?=
 =?us-ascii?Q?lYD5B8NIRahMM/35WV5R+NHv++l0fsEjl/lyS6SiQvyu+NAZOGQUowwqEgsX?=
 =?us-ascii?Q?UoyIP/+a/TSHWKK8spZwM0YIUJGtLF12U+dv26LGBhyL121hWZTRM+7YTfFi?=
 =?us-ascii?Q?FnLjDGFsdLaqaso9+IgoRPzM1hIBTj8xVs3h2RmEJnmjhsA2aS5LxZl7ys0Q?=
 =?us-ascii?Q?Pd5hB7xsu/L+UF/c1qR0vhPF12MYlb0Kep/gNGhXVpKZq4gv+CdwhYbgxYtG?=
 =?us-ascii?Q?7ZU7Eg7PVO3EbaIy+ck=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR21MB1324.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f148566-3e49-415c-c0b4-08dc97a7e2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 19:24:10.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJ71YVZCD7NTlzA4BkK5j0LF2HRsai8cBJhowWJORxXz67mmawMh2Th/pP+aOy9i8KgHsSXdVj+L27hOXnTrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3958

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Friday, June 28, 2024 3:05 AM
> To: Dexuan Cui <decui@microsoft.com>
> >   [...]
> >  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
>  [...]
> This patch collied with kexec changes. tdx_kexec_finish() calls
> tdx_enc_status_changed() after clearing pte, so slow_virt_to_phys()
> crashes on in.
>=20
> Daxuan, could you check if the fixup below works for you on vmalloc
> addresses?
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index ef8ec2425998..5e455c883bcc 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -813,8 +813,15 @@ static bool tdx_enc_status_changed(unsigned
> long vaddr, int numpages, bool enc)
>  		step =3D PAGE_SIZE;
>=20
>  	for (addr =3D start; addr < end; addr +=3D step) {
> -		phys_addr_t start_pa =3D slow_virt_to_phys((void *)addr);
> -		phys_addr_t end_pa   =3D start_pa + step;
> +		phys_addr_t start_pa;
> +		phys_addr_t end_pa;
> +
> +		if (virt_addr_valid(addr))
> +			start_pa =3D __pa(addr);
> +		else
> +			start_pa =3D slow_virt_to_phys((void *)addr);
> +
> +		end_pa =3D start_pa + step;
>=20
>  		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
>  			return false;
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Hi Kirill, your fixup works for me.

BTW, I just realized that virt_addr_valid() returns false for a vmalloc'd a=
ddress.

Thanks,
Dexuan



