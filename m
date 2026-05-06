Return-Path: <linux-hyperv+bounces-10649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JxQCTNV+2n+ZQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10649-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 16:50:27 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DED4DC98E
	for <lists+linux-hyperv@lfdr.de>; Wed, 06 May 2026 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117D3304E30A
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 May 2026 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4740B6E8;
	Wed,  6 May 2026 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J5LPq89A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012048.outbound.protection.outlook.com [52.103.10.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28C3EE1EA;
	Wed,  6 May 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078196; cv=fail; b=KmxnPy2uunoOfjjK8rSy4/5W5edykUhD63MFLBwrna5pFARcPe9ZrgcsjLwUjb7I048E+FzOVV8dDFDqvumbepwBVKIeJS1byQQyDC3R5AtVEyHTjrRXMvTjhGVhUH8sCVpIhXwLUsnqsW+M96h3RwLLfYKk954jqHBzcWEqYiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078196; c=relaxed/simple;
	bh=b5sSFZeVuzJUD8G0V+4M1JrvM7styGoNIZFEep+vkL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huJ2kw/fxaPVXcyDE4xoJYRJ0Nveotxihp9vtj5104aN26TzHGEXala/QkavLmmbvUBhu7uVTH8vtQzp/zyiW9xAjLBwtureHxh7kg/6KX3dUeddWS+VweQWpRaJYkWNjeNrAlMqiZV1O9Yn74RvbOGJxtcY3TB0djth29x7Nmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J5LPq89A; arc=fail smtp.client-ip=52.103.10.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV6NCSyPkWLDoDiyQvtx/gFo9hSccnDSY1IEWE+XZTEDjz5uYg9JusrX7wsy+144nmNxQ66EoqWqhQBgV2pEVH8HxeymcWrKWiMrY+B/nmb0KhNJBuFqEQ6sKcWLmvmb+SAo6aY0/LXMtuc2Fs21qTFnbv4nDtp1RArdZR7n//t1qavK9CODxq6U9eNlJb5BdRqnZqOt3zlaty+lfG+mSVNKOtgGcW+Hx9yMvQeaek7djSZzlHtrJzsJdCOyzT85tDkb14zlQ1lBxSiGFFxWNrRoDMcLDTWu9PiAfDP78qGXw+9cXIGViamLZibbP2uBX5YrW8O1yjSt9WqupLMhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1IRyPESnisKXlkxEFzWzSZt3/CaTy6k7s442lpEm0A=;
 b=HuEaI6mzGvRJJS6APA5l7BPXM5Dqfa2wna8T0/AGFuOa0WzvJDTgecsVY2oRq5ul6WaO8et215SdXtyA8ynJd0V4GTABD7NToccj3QXaGHfZbsh06MdMV1rYVsuqqDBAQQyOhvMW6r9bTcAGe6+1vH1kiZaxQsN381PTFM9dlFlJRY3BdNR5FJ/kc+Y7xfHlyIg1DPsEYMma31iwM80NNfjoYZ8G2bsW4V0r/FwBO1naM1kKA+3eeFf7RbWR+RTe2f9Y5CQbWtlFlSunHJ2Lyw9jL7mUTUEKwlWpGGp17mQTPJh0z9pUNDb+7RxvROuic/dGIcXTfbcKRh0XUvMFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1IRyPESnisKXlkxEFzWzSZt3/CaTy6k7s442lpEm0A=;
 b=J5LPq89AUtH5m8Ymhzt78Ez/MME5R6ubnZQMfaCcI6wUMAgyNLJa9fuXO1sojVf/7JHbYkfRHKOY2uJJADoloReVBz785jlsp2Dm3qIF64miM26ueBzv05ISpLx8JFTh6WriSbUA+FUP3p45RQpx6G1KMVIsA11ZvhRBOUtzydEHC1MFSKDXcQymCfX78Jo5W4NKkvR0AQtSQUkCpcBobQprYhP9YlzsG4mEtZTU5rXVBVaLUbksFFDlQqfcOVuyaEEmuEd/iirVqXwfJjvQYQgXyDze2S1Vm4ZpL5qRf20Flpz5fOkYC2OnSPVjbraDrKzEIBrFzwHJGLP64csY3A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB8928.namprd02.prod.outlook.com (2603:10b6:8:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:36:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:36:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
Subject: RE: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Topic: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Index: AQHc0x7PKig5dZReokG7sAarwbgXxbXyan2QgANsi4CACEKMcIACeJ+AgACS93A=
Date: Wed, 6 May 2026 14:36:31 +0000
Message-ID:
 <SN6PR02MB4157D109AF4B5C62EF7F0E2CD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-10-namjain@linux.microsoft.com>
 <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <567cf73b-6a48-4fc3-b312-9be6d71e2f22@linux.microsoft.com>
 <SN6PR02MB4157AD364DE0755DE070D286D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
 <024aed8c-cd97-45f0-a653-489fc334a2b9@linux.microsoft.com>
In-Reply-To: <024aed8c-cd97-45f0-a653-489fc334a2b9@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB8928:EE_
x-ms-office365-filtering-correlation-id: af6d726b-1294-4c27-d2ed-08deab7cdd84
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|41001999006|19110799012|13091999003|51005399006|8060799015|8062599012|461199028|19101099003|55001999006|31061999003|10035399007|4302099013|440099028|3412199025|102099032|1602099012|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Rf8XXGl//YUGjJNFZUjXtvlG4XNEs/yDeKJlQ1gAc0LdMFYlbL206u+tC+Z4?=
 =?us-ascii?Q?9RIMGzeuS6R62xUCns1b+FFumj+w6DNz+1bVmZWlzDYuTl9xIl1Qsl/xcDAk?=
 =?us-ascii?Q?OBTt7eiTok+I1XdAz7U5R1ke5Bb8QlUsyIBxNPV5p/VG180M9mRvz2utssgp?=
 =?us-ascii?Q?sezlBOyNH74pUBEgdnP+Zf+9SADbPlya4CwMD+vMdT26NXXrCLe7dTiJzsCt?=
 =?us-ascii?Q?idjOv2/vf2q10LB9k891L0fSWQBRWqvogOcwZ7tzNRoO/4wzjTtiWS/VqqiC?=
 =?us-ascii?Q?FY7l/+H1Gasa/2pczdjEiCvZamXEIbji3eldj8TTEudSJqjbTp1RSQw3gn0P?=
 =?us-ascii?Q?pTJmfB2Q9i3+q0ifqOtp0z8l+RwtMH/TNU0CSwWF6u4EvZ27JX8kPRN9EVZw?=
 =?us-ascii?Q?RHK77QM+Bnn0/SRkuP/4DNDxHBHduJNj1h+NUqWSgxrN+QXaNK97O99ahYku?=
 =?us-ascii?Q?Dx9CBTq5+SDZxea567PTwhcVQ+bRTMba56JaLs7E+uWzjkid82z74ipEpooJ?=
 =?us-ascii?Q?c8Ty1n0fmkBjbAaGBZCOMpBt0zTm/cauZGRUJ8+exXz5dCe+j2qayvP2aEjo?=
 =?us-ascii?Q?8v4gJtjQA+aNDdmz6aXuRVmFjj8uUmkd8nEIb2sTPS6l8wqICWvADvgxXp6+?=
 =?us-ascii?Q?eq5BhbkP7LDGF7Pedf0J+YqTRTpoXZRDLyLlWtaKbV9hDGmCjkis6s6Qbf2t?=
 =?us-ascii?Q?vOpvkJZuVadTyoLpKMpBVPQjVTBhnP9Qi1swiOomNVoL5EEUUHb4OormN3V5?=
 =?us-ascii?Q?tKl5IlRtJECJWEzk7Qhafxm3Mu6CrD91qwkIjPM1Lb7/+vwaHg26z8RWVDVI?=
 =?us-ascii?Q?2BXLhQHyU4EDtbDchF7RB2y5xWujo7mLSakZaj+FvkNWU+UlSNqZLLNj+4on?=
 =?us-ascii?Q?TdlTtWGiaN3kKic0iP7lNAEC47MiHKBjl1r3KnrJrkfAC7g0Ur5vOkb8auV3?=
 =?us-ascii?Q?dcbWxU9Gb3syqnE4k8E3c1cpFaCtB7iNv2v0qoFy76DwKUi6laot5ao5snIX?=
 =?us-ascii?Q?BKs1spcbGBvSUGEkTeuIm6BfHmsBkLpA2FCBv/Hx/HkNQY++byCqJsVcusQi?=
 =?us-ascii?Q?8Ap0/r6GeA+br3tYoPBu2jqFCZLx3XCbeQwEJvt+sXK6egTv7M4kXx0bmb9u?=
 =?us-ascii?Q?zQsMQ6px95KS?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KQmGg3qPblHshAbsAMrBXeVHejCnXhsDWPdX8bK2ecOzEZmpsrRra8bjf06e?=
 =?us-ascii?Q?ktPc1MFxaR30pN1l8IrKeAeIoAFVFX2CIIbdI1x14ooWQWoeTgSf4+M25xMC?=
 =?us-ascii?Q?UKyy+RrHidim03MBm3+12fSXGJ80j1FQCNkTpJwDua6r+CNsX4mjXtu2F1Ww?=
 =?us-ascii?Q?/wVNA4i3m7z2qAuVXRol6hbJib//EKuw3rJwWuAa/wOfb32vCuqLm7FshZyS?=
 =?us-ascii?Q?fJ8cmkR3qxAFzkb0XePA4LSqs0MOveX7gxXLPkY3boCH4Q+dP5N38GAXrJuP?=
 =?us-ascii?Q?0JZgXzNNmJ9JzG8LCy7G25jTRjTNdL40RDGr9kxz5mIGkJcKIGqSi9uYQP0F?=
 =?us-ascii?Q?rH0C3XHyziuahG4DiJLqSx/+43fVNalK0fV6VZS6bUR0z4J+vkdySaeqp+JC?=
 =?us-ascii?Q?0X42zNQ9YYAq0jIcbouQobbc5UpEJdrZ2Rqcq8G+zwn29NeCnaOihGsm88+L?=
 =?us-ascii?Q?Dkz9pxBM4GK7IaiJbW/2nb1BIkD44xmHVjNAsJGZAxHuK6AeOxMPQJf6ax+b?=
 =?us-ascii?Q?UGaLyAzVp1uLRxo+lVrLC1+Zy4VMySTv0KVzEgQTN+pAzPDQu5JIuvXtWB3X?=
 =?us-ascii?Q?bquevU4PVq0mlhVocK3bHgOgxkVPh2KRLq53QdqCniJiPwcHG/cgLwNXNCuW?=
 =?us-ascii?Q?koLqP46KYfL68Vx8oxX4fnyiX3P11p3LoNeYwqN2g7izWCiQtouQra1nJ6rY?=
 =?us-ascii?Q?Ut/KQTUjNVrB18323/4Pn20f9rQr+c4n2Cu5Aiq6lAfW6CTyGmH0M219Y3Uf?=
 =?us-ascii?Q?7fH7vljryFAdZIBFbfwxolK1JCTXF5OhGdpkArOwuKqXTHWCcm7CAvt8y4tH?=
 =?us-ascii?Q?kzMizC7zw82QUMYBMURiQJwvHnf9pUeo9Se6BrsjiOt3C0REpJxIcrqKhXC+?=
 =?us-ascii?Q?+YmFmsGMBDrE5cy/q89n+DcrnPo+UqQTFVASUezwO/bPilgQodIOZOqvELL/?=
 =?us-ascii?Q?LueOBWS6qQRr3/cg2NpdpofCPplfx/PFRYIF4kquwZNCr9omSEeUYWBvkZpy?=
 =?us-ascii?Q?RYBtztdZZM4LoXvWGSqE9DwXMB1GHP7qpjB7364F8JcOwCsgHhBx0kkDtkRS?=
 =?us-ascii?Q?l8aU4qG2qBslhIkc+v91Zk7ebUgz3AwELT4d7kkgr/JHnZXTNEZJpyRmbAR6?=
 =?us-ascii?Q?DIXGmwbqc9K2iBCaWtojN8tDIvS64VYVxzqWa570SNoInjFHHRw+zzxaEMk2?=
 =?us-ascii?Q?/v5snnfF8JmSAqZI/8DO4FknCrFmgk0sdlXPg0N1CLo9hq0em3tw5dwa8EI/?=
 =?us-ascii?Q?lom2i01Kvxif0Dcvk8//ieUfAmceTB6rh9tjVf0UuglQ01Prqcz56HmR+lEq?=
 =?us-ascii?Q?FALJWW6hgpwIs4gaZiTET1yAVVlCcTR7bnpjRrfc/WGEQxCEDXY2EJ5IEJMc?=
 =?us-ascii?Q?uNVxCEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: af6d726b-1294-4c27-d2ed-08deab7cdd84
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 14:36:31.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8928
X-Rspamd-Queue-Id: 73DED4DC98E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10649-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com,outlook.com,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Tuesday, May 5, 2026 1=
0:50 PM
>=20
> On 5/4/2026 9:36 PM, Michael Kelley wrote:
> > From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, April 2=
9, 2026 2:58 AM
> >>
> >> On 4/27/2026 11:10 AM, Michael Kelley wrote:
> >>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April =
23, 2026 5:42 AM
> >>>>
> >>>> Move hv_vtl_configure_reg_page() from drivers/hv/mshv_vtl_main.c to
> >>>> arch/x86/hyperv/hv_vtl.c. The register page overlay is an x86-specif=
ic
> >>>> feature that uses HV_X64_REGISTER_REG_PAGE, so its configuration bel=
ongs
> >>>> in architecture-specific code.
> >>>>
> >>>> Move struct mshv_vtl_per_cpu and union hv_synic_overlay_page_msr to
> >>>> include/asm-generic/mshyperv.h so they are visible to both arch and
> >>>> driver code.
> >>>>
> >>>> Change the return type from void to bool so the caller can determine
> >>>> whether the register page was successfully configured and set
> >>>> mshv_has_reg_page accordingly.
> >>>>
> >>>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> >>>> ---
> >>>>    arch/x86/hyperv/hv_vtl.c       | 32 ++++++++++++++++++++++
> >>>>    drivers/hv/mshv_vtl_main.c     | 49 +++--------------------------=
-----
> >>>>    include/asm-generic/mshyperv.h | 17 ++++++++++++
> >>>>    3 files changed, 53 insertions(+), 45 deletions(-)
> >>>>
> >>
> >> <snip>
> >>
> >>>>    #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
> >>>> +/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> >>>
> >>> This comment pre-dates your patch, but I don't understand the point
> >>> it is trying to make. The comment is factually true, but I don't know
> >>> why calling that out is relevant. The REG_PAGE MSR seems to be
> >>> conceptually separate and distinct from the SIMP MSR, so the fact
> >>> that the layouts are the same is just a coincidence. Or is there some
> >>> relationship between the two MSRs that I'm not aware of, and the
> >>> comment is trying (and failing?) to point out?
> >>
> >> This was added as per suggestion from Nuno in my initial series for
> >> MSHV_VTL. If the reference in "identical to" is misleading, I should
> >> remove it.
> >>
> >> https://lore.kernel.org/all/68143eb0-e6a7-4579-bedb-4c2ec5aaef6b@linux=
.microsoft.com/
> >>
> >> Quoting:
> >> """
> >> it is a generic structure that
> >> appears to be used for several overlay page MSRs (SIMP, SIEF, etc).
> >>
> >> But, the type doesn't appear in the hv*dk headers explicitly; it's jus=
t
> >> used internally by the hypervisor.
> >>
> >> I think it should be renamed with a hv_ prefix to indicate it's part o=
f
> >> the hypervisor ABI, and a brief comment with the provenance:
> >>
> >> /* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */
> >> union hv_synic_overlay_page_msr {
> >> 	/* <snip> */
> >> };
> >
> > OK, so this union is not associated *only* with the REG_PAGE MSR
> > (though that MSR is the only current user). Instead, it is intended to
> > be a more generic description of MSRs that set up overlay pages. I
> > don't think I had previously noticed Nuno's comment on the topic.
> >
> > Looking through hvgdk_mini.h and hvhdk.h, I see 6 definitions that
> > are exactly the same:
> >
> > * union hv_reference_tsc_msr
> > * union hv_x64_msr_hypercall_contents
> > * union hv_vp_assist_msr_contents
> > * union hv_synic_simp
> > * union hv_synic_siefp
> > * union hv_synic_sirbp
> >
> > There's an argument to be made for removing these 6 unique definitions
> > and using union hv_synic_overlay_page_msr instead (though "synic"
> > would need to be removed from the name).  I would not object to such
> > an approach. It's a small extra layer of conceptual indirection, but sa=
ves
> > some lines of code for duplicative definitions. The alternative is to d=
rop
> > the idea of a generic overlay page MSR layout, and replace union
> > hv_synic_overlay_page_msr with a definition that is specific to the
> > REG_PAGE MSR, like the other six above.
> >
>=20
> Hi Michael,
>=20
> While having a generic definition looks good to have here, I can see two
> reasons for not going ahead with generic overlay page definition:
> 1. All of the above definitions are present in Hyper-V headers and
> generalizing them would deviate from the strategy of keeping the kernel
> headers in line with Hyper-V headers.
> 2. For any of these definitions, if the use-case requires using some of
> these reserved bits, then it would be a problem. I can actually see that
> happening in "hv_x64_msr_hypercall_contents" in the corresponding
> variant in the Hyper-V header.

Your points are certainly valid, and I'm good with not going the
generic route.

>=20
> > I could go either way. If we want to use a generic overlay page definit=
ion,
> > then that approach should be applied everywhere. With the current
> > state of your patch set, we're halfway in between -- the generic defini=
tion
> > is used one place, but duplicative specific MSR definitions are used ot=
her
> > places. That's probably the least desirable approach.
> >
> > Michael
>=20
>=20
> Now, coming back to the hv_synic_overlay_page_msr definition. While
> Nuno's comment hinted at it being "generic", the same is not documented
> in the name of this structure or its comments. So it should be safe to
> assume that it is specific to synic_overlay_page_msr usage. But since it
> is not part of Hyper-V header as such, we needed that comment:
> "/* SYNIC_OVERLAY_PAGE_MSR - internal, identical to hv_synic_simp */"
>=20

An "overlay page" is a generic concept in the Hyper-V world, and it is used
in multiple places in the guest<->hypervisor interface. The old PDF version=
 of
the Hyper-V TLFS describes overlay pages in the section 5.2.1 entitled "GPA
Overlay Pages". See [1]. Unfortunately, this material about overlay pages
doesn't seem to have been carried over to the web page version of the TLFS.

So in my thinking, the name "hv_synic_overlay_page_msr" is inherently
a generic definition that could be applied to multiple MSRs that are used t=
o
specify overlay pages. Your patch is about a specific MSR,
HV_X64_REGISTER_REG_PAGE, which happens to be used to define an
overlay page. But if the decision is to *not* go the generic route, I
would expect to see something like "union hv_x64_reg_page_msr"
that is specific to the REG_PAGE MSR, and to have that type used in
hv_vtl_configure_reg_page(). The definition of hv_x64_reg_page_msr
would not have a comment referencing the SIMP or any other MSR
because it would be a standalone definition that is specific to
HV_X64_REGISTER_REG_PAGE. Then the pattern would be the same as
the other six cases that I listed above.

When not using the generic approach, hv_synic_overlay_page_msr
really has no purpose, and could go away.

Michael

[1] https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/=
tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf

