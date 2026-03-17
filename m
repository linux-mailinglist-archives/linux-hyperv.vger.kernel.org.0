Return-Path: <linux-hyperv+bounces-9504-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EHRIeiguWmiLQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9504-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:43:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 006812B1105
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB4CD300E627
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B433F54CC;
	Tue, 17 Mar 2026 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PDA+XxDl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358037C0E0;
	Tue, 17 Mar 2026 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773028; cv=fail; b=caZL5ooSRtPzsh8/Y17JIAPR1kN56t+Z7RdxM/AcwbwLhSyLq7kAbMIHfK6vgWGwrCak8JsI4ovCwOrmirWXDjued/nCddoEZGYrAj8uK10qFOYpv0gQdw8RJSRcOdUhStYgdq4gkKVLI2X29DBY1rkAfnF8IboKSVef/gv2j5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773028; c=relaxed/simple;
	bh=xkM25DCxudWpLKHYXYHJgunu5syDRy+LTEH8yF2SdwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HL4pc5HGIoAv/QeVj2wiWtKuIeMro83k7cEuknVrE4f+THe7Uy9sSRHJYM5a3T5Y480memhCgHMWqC+9VAFbSTaWFJsqFATXTF2BwVbr3KLL8HBlISefnhLWa9kEr8SU+OfXY1iTZoozsI1BjO6BqhGTKOZ033B6nwVJm0jKETw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PDA+XxDl; arc=fail smtp.client-ip=52.101.57.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npWmKGLmQUiH/PRvbkI94e/rphU4K5SI4trl0CJzORwCv4lBXh7NlbVGozAv4uv0HoJaaD0j6nvh943vybkecC7QzfJWXBgz+JcDq3a2Q5UDmpnxwegWxYX5OxBPgtY3rcvgOJty4tZtjGTxvUaPkYa316PjH8V4znyV/58HMbLqKcZcn7vYS61tG6LvwLwm7onn3UbZM+5m2RXDdtOBD3+GETQSQWnk639TyxaFcnnK6y8sy3y1i62iZYjsaFFWQYibFYReHw6KkmNaCJYQ7eYC5kkrol+mpyIbzxUxiAua1N2EDIF/1gK+V5Sh4yq0AnoXUct3MyDg6M1g2v7zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onHxDYRXEFvNufyMepXViytnM+yen1oyBJbZIt2O2jo=;
 b=m1J7qpNpy77axiV7P3zeV3GUOfnVNS1BFCGRMkco1wAiDWoJ4WgWvBaEOvH8AD0ZFJbY7yUGyeJn+g/pYB6h4Fz1rUwJQD19eVd0LjJH7z99maz1LeFjMMUya02261pL9U0HkPRozI375mJ61mT+qqnssMJt1gRYVsUf/WSEebFWj9j5Lj8+yQnshHCXSI/duQOJJ5NgvkpkWg7XfYa+Wqbu1etDe+LPc1+S9HDNe2MXQq/3xIpfTJmICTxwlgJr0KN5rf/XjkWRadzAIHkriFLtaW6Ae7lA7lr66+00FGtjL8FRBLcHOG1i+lwoDABhKR/JPyTzVWeoZA6+y7NcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onHxDYRXEFvNufyMepXViytnM+yen1oyBJbZIt2O2jo=;
 b=PDA+XxDlwUnzHzk0Ql6rEtXSaLQIHriR7lf1kb7T6Q+BHP7rKvvqJRE3Hih1QUWdfRs2edr1HkS8nXtjhsYphU05oGP10bMxxFXn2uIrGIhw8eR4n4d5fA8VpPjsrfdUyrY7EclucRlYvCxWONKcFFtV0zWFdEJNuCwEiOz39E0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV5PR21MB4944.namprd21.prod.outlook.com (2603:10b6:408:304::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.8; Tue, 17 Mar
 2026 18:43:44 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 18:43:39 +0000
From: Long Li <longli@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, "drawat.floss@gmail.com"
	<drawat.floss@gmail.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"ryasuoka@redhat.com" <ryasuoka@redhat.com>, "jfalempe@redhat.com"
	<jfalempe@redhat.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] Drivers: hv: vmbus: Provide option to skip
 VMBus unload on panic
Thread-Topic: [EXTERNAL] [PATCH 1/2] Drivers: hv: vmbus: Provide option to
 skip VMBus unload on panic
Thread-Index: AQHcmZIP2DJLtGI0y0OGUoKeKTpA17WzSL0Q
Date: Tue, 17 Mar 2026 18:43:39 +0000
Message-ID:
 <SA1PR21MB6683540B9B3CCC1F605612F0CE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260209070201.1492-1-mhklinux@outlook.com>
In-Reply-To: <20260209070201.1492-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b657ea06-fa6f-438d-ba50-8c59d1327667;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T18:43:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV5PR21MB4944:EE_
x-ms-office365-filtering-correlation-id: 7857cb80-929b-4b58-0e94-08de84551b1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 J3k77ow+lbglxnMVR+d1woqvjmddSEQKW8lPOHQSjMV8xWcQmbq7pZP2+tQgNqjBPN769hRW4proWfNcqEiy7vGxPZDX4VrrlXAo5LHq0HSTQFXEnh8FMMozd3uS0VWmqsbLkO319lrMMO0RNHl9swEnAclhgzEiFMtt8u+e1bWhIUvDAS/gMXQTdWcGT20EMupJ+yWHQ86H4V+lw6FZzcEdZaUsndcoa5S1uiH8KGCwe2JsV/mqCIbeciHi/sXcrkZsxRAc8Wxs52e89OtXPsjRqzGAZbGTuojiQDqL2d0Ec0p7tiumJKJVLEdRL9QnU6w++6vbtO576vOCNXUzJQI6zWRPwszRVSywBdemhrnGSuQlvFvOsLjEEbLesZbTVKebZ6gzfrjU9QJZ127fYwYUtbCL3k8tWEnzyQFZPoxSjfNoANid9CgAuaKAJyQGa4MeNWz/ZTXvYgGwVwvMNwqVNVskhxFzLD6mP8/7hUwac1dv04M5Yv8rQfhOzeekq+UUG652IwzyMTZNXFqpaL1Q78xxGqUYR0JP8JieAcKA1Pgqj948wAbwVRjUMS4f1bYh3OWwAJ/dGcC3/YJr4APzWTwbsD7H3COZuSQSpc5sT0EM48BC0VYJ/m0SWTDgEKpkBHHdnb4zSNJlwELvjP3g6mX99//biXRjgNjQI7ZQdatfZcEJFnQH4B2fU2Rk5Qxi0dFYtfpWErbMXAO78N38BE3NaCUtPjgx/JY5iz61D990foiw52550cyIub49+bSpAA994KKkKv+S43EIZsdRKnFiTLJQ6dnoY+7d/nJ7U1r6wY7tiTPtU8KwnUtY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V3vR79mN0Z7MY+d8+aMlpgZmajgGM4ax8Hfbqv9V0iMLBdWakVJM6CMIJrpU?=
 =?us-ascii?Q?54myaFx4qm1A57JO9ncRwyOc0+z+ImiqMAswbnFl8wndXixNCPgNekfkN2fH?=
 =?us-ascii?Q?dzNTM5pdS93hXaukMF5FjVP2J61wVQin6Oj+Im4Q9vNoGWdRFJefPu0OjIr+?=
 =?us-ascii?Q?Exu/7MM0rQ9I/XkpQIw5/80eYDXKrqFZNtDWfFgWtj1M6W7HthnK1ehLFKdR?=
 =?us-ascii?Q?I7yOnVFXJw3Wm2olnhkvVZA2344tR4M/pFp9p+/Oq6o1kioeMEhNvv7YjQRV?=
 =?us-ascii?Q?zcgb1V1auhqtg/t1SiaqdJ/+wT91b9jMXjpxqSbtgaGYnzJ2ARbEAa2XWyZ4?=
 =?us-ascii?Q?DctC4Irp/3UsTTcT6NHLnb7S/SemBX5H5PrJEsrJw8zf0+zwwqYsFKOZ5WCr?=
 =?us-ascii?Q?jCMioOQ/t6I1vVNOsO993ScCNaXuFOmd5U6/3VFDLaHuXfnJJcVpANdHe1uG?=
 =?us-ascii?Q?J9GRBowbPUDD7xeany/CtaLZOv2ZuoE4qtv3VUJF+r8HwKXgzWZLu0AJzJG4?=
 =?us-ascii?Q?dMvRYeQA6TlVLJuwBgWL0xdJ+FfEKzQYU6XzxPHGdmxgysk5HKC970opM8lB?=
 =?us-ascii?Q?52SI4YACuV/WqzdJ1ZY0KBkmpquGEMmNmKYwY1oVH++XeUM1hgjCSlqoZ+4/?=
 =?us-ascii?Q?Qdf+U7UL5K7ZokvNMIBZyEourAz928VjFWn0tuKygYOpAUW9ADJGBzRZdE97?=
 =?us-ascii?Q?3aq1AvwqX1QbZd6OSECsqZPVbBV+FD2/frCe7ByA6+A1T05fv8XfJripi+V/?=
 =?us-ascii?Q?AGz+ukGFmVP4nCzUaCuGBiSB5xvBlfS6vRmW7dzkyhqq2gKjHm0U8zrf5622?=
 =?us-ascii?Q?olaqQZqtgxUICMWIJKXHFd2Ar4fr0YDzhVSvEv507xkR7WIaGT3iXpSGrIEe?=
 =?us-ascii?Q?NLzZOsprR9ZBK0s8hzrsdY/UivW8wHSqGT3SLo8z5Yff3ncjPSIm9/ki9orL?=
 =?us-ascii?Q?D0tVaRUamI85n3+1YQ6JLgJWc6VWxKumVkn4NWU5ggLgAJcswfdKMX/lNq2T?=
 =?us-ascii?Q?x6gX87/vAcNukAS382Cj0NNJ+zF1JOuuQhcQNp8lpPoklX8HDQyvjsIE+oB8?=
 =?us-ascii?Q?u44cRhsuw7DVe9PuQv1fg6oZREzb3skqGIpEQ95+4uKo28eI9j41B68T71OX?=
 =?us-ascii?Q?5PGLrXN2D6HIDFOFm2NSVqAxTZP0T7hbKFMdbkV4+f4Dfp13Z8cEMil9le1z?=
 =?us-ascii?Q?LWgeRvcmFKzzTAEr91DhZOspaIF8Wwc29pj2XFfOL8r6cUa+sgVJ5/puoVl/?=
 =?us-ascii?Q?0eRwT0s+sgECNhobLznCdQeZdH0Yo4t+7k5lQqnMcWjGEhiOhTRQmPBr5lfD?=
 =?us-ascii?Q?Y3BjLI58rtudc7qQHekW5ytr/8OUYYvAJcNh6NIRPy38u2rruAKgtftobdwu?=
 =?us-ascii?Q?3y32C9pYrzE5ywx2D0F3gtEMxImYf/sEkXI+/nhOiR8DKkz2wjhDFr38qbmz?=
 =?us-ascii?Q?xbZNDGXWeElgvLoN6V9z7ffWPsOo2keRKAo5iJDthFW/3SWXgOOUPxTe2nQO?=
 =?us-ascii?Q?t+oM/9ze+wm1wG6/VNzp5BwLtXWbZ75LNemUUc0XHA996acfMPdciz5n/a0S?=
 =?us-ascii?Q?vnQcW64izN7Wq5H98uM77yaHaTQnVKao2Mhg0pTx8RpUpAdThGTXFom1SCSM?=
 =?us-ascii?Q?JzEd8gOjbA51cO8GGrvHcngo1ZmNEc0ryRWCfTttxOkePf3mQi7HltzD4f7d?=
 =?us-ascii?Q?0qCSyVfo6A6FdQrNYWji2NZ3DUbawd0888GWQllfcU9dLu1w?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7857cb80-929b-4b58-0e94-08de84551b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:43:39.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cV3f/ei1hFtZn0u/CO2gRFG4MXTCk2uZt/XNnRSfz9P5ig0cdjcotNIt1lIw8wuoqJ5ouDsKpTNDYHOEgif3xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4944
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9504-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 006812B1105
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Currently, VMBus code initiates a VMBus unload in the panic path so that =
if a
> kdump kernel is loaded, it can start fresh in setting up its own VMBus co=
nnection.
> However, a driver for the VMBus virtual frame buffer may need to flush di=
rty
> portions of the frame buffer back to the Hyper-V host so that panic infor=
mation is
> visible in the graphics console. To support such flushing, provide export=
ed
> functions for the frame buffer driver to specify that the VMBus unload sh=
ould not
> be done by the VMBus driver, and to initiate the VMBus unload itself.
> Together these allow a frame buffer driver to delay the VMBus unload unti=
l after
> it has completed the flush.
>=20
> Ideally, the VMBus driver could use its own panic-path callback to do the=
 unload
> after all frame buffer drivers have finished. But DRM frame buffer driver=
s use the
> kmsg dump callback, and there are no callbacks after that in the panic pa=
th.
> Hence this somewhat messy approach to properly sequencing the frame buffe=
r
> flush and the VMBus unload.
>=20
> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/hv/channel_mgmt.c |  1 +
>  drivers/hv/hyperv_vmbus.h |  1 -
>  drivers/hv/vmbus_drv.c    | 25 ++++++++++++++++++-------
>  include/linux/hyperv.h    |  3 +++
>  4 files changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c index
> 74fed2c073d4..5de83676dbad 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -944,6 +944,7 @@ void vmbus_initiate_unload(bool crash)
>  	else
>  		vmbus_wait_for_unload();
>  }
> +EXPORT_SYMBOL_GPL(vmbus_initiate_unload);
>=20
>  static void vmbus_setup_channel_state(struct vmbus_channel *channel,
>  				      struct vmbus_channel_offer_channel *offer)
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h index
> cdbc5f5c3215..5d3944fc93ae 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -440,7 +440,6 @@ void hv_vss_deinit(void);  int hv_vss_pre_suspend(voi=
d);
> int hv_vss_pre_resume(void);  void hv_vss_onchannelcallback(void *context=
); -
> void vmbus_initiate_unload(bool crash);
>=20
>  static inline void hv_poll_channel(struct vmbus_channel *channel,
>  				   void (*cb)(void *))
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c index
> 6785ad63a9cb..97dfa529d250 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -69,19 +69,29 @@ bool vmbus_is_confidential(void)  }
> EXPORT_SYMBOL_GPL(vmbus_is_confidential);
>=20
> +static bool skip_vmbus_unload;
> +
> +/*
> + * Allow a VMBus framebuffer driver to specify that in the case of a
> +panic,
> + * it will do the VMbus unload operation once it has flushed any dirty
> + * portions of the framebuffer to the Hyper-V host.
> + */
> +void vmbus_set_skip_unload(bool skip)
> +{
> +	skip_vmbus_unload =3D skip;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_set_skip_unload);
> +
>  /*
>   * The panic notifier below is responsible solely for unloading the
>   * vmbus connection, which is necessary in a panic event.
> - *
> - * Notice an intrincate relation of this notifier with Hyper-V
> - * framebuffer panic notifier exists - we need vmbus connection alive
> - * there in order to succeed, so we need to order both with each other
> - * [see hvfb_on_panic()] - this is done using notifiers' priorities.
>   */
>  static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned lon=
g val,
>  			      void *args)
>  {
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
> +
>  	return NOTIFY_DONE;
>  }
>  static struct notifier_block hyperv_panic_vmbus_unload_block =3D { @@ -2=
848,7
> +2858,8 @@ static void hv_crash_handler(struct pt_regs *regs)  {
>  	int cpu;
>=20
> -	vmbus_initiate_unload(true);
> +	if (!skip_vmbus_unload)
> +		vmbus_initiate_unload(true);
>  	/*
>  	 * In crash handler we can't schedule synic cleanup for all CPUs,
>  	 * doing the cleanup for current CPU only. This should be sufficient di=
ff --
> git a/include/linux/hyperv.h b/include/linux/hyperv.h index
> dfc516c1c719..b0502a336eb3 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1334,6 +1334,9 @@ int vmbus_allocate_mmio(struct resource **new,
> struct hv_device *device_obj,
>  			bool fb_overlap_ok);
>  void vmbus_free_mmio(resource_size_t start, resource_size_t size);
>=20
> +void vmbus_initiate_unload(bool crash); void vmbus_set_skip_unload(bool
> +skip);
> +
>  /*
>   * GUID definitions of various offer types - services offered to the gue=
st.
>   */
> --
> 2.25.1


