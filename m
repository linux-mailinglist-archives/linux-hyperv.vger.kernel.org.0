Return-Path: <linux-hyperv+bounces-5230-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF6AA4175
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 05:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3451BA5FBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B498126C05;
	Wed, 30 Apr 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fdaanyWr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2032.outbound.protection.outlook.com [40.92.41.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D6259C;
	Wed, 30 Apr 2025 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984545; cv=fail; b=tZ/O7wAVpEWp1V0vPkuctJ1Mu429ueJY9iFpObcn+8wpwsVLkIUIYOwvcVb09e/kVU0p1/54qnKRNJHAkOdqVbT+emtVMYagqnzRYxz+oOjJaqWjCGlB3ELgvPgOzSDB6U/wYh1T/pAhHl1sEQZdEUsl9a8up5gWXGK+vAHbv4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984545; c=relaxed/simple;
	bh=8eYzUKgsrKgydlb8F8ctecUGLw8oIt8YRXnSIZGVxNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3iP2o57WjKKxDfYxh//WI1KuhV5FBCHWLBt3qtRVkd/qtP+SoHMx53Ymn9JL1jyg97G+/9PNuqI1luRZu5VmFjj5PXcZ7acLVdIOpM8HKSZ86cWhkOCncDn1DvqhBMIVhauDoNTrq/VmJ5aOc0fsi5aytLHkyElxUTroGBkx/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fdaanyWr; arc=fail smtp.client-ip=40.92.41.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrKxeT+NbnlKOrAWhEZpHmMmtowNI0eRfXvjulH6mAKXgZrUhnRgq3yKfdgPq355xNM+OKRwjb5h6DdYix9b03MrzRzFgQEoDqVP8gtj4c3g4hDgVxFxjaczwU6YtuGf5TDI3ZsgV4dTLJYocvVjaqRynQKJGXVXEJl1okj29kw5bSl1s/EYLCOibWVLQ7Oci9b+dKlZx/5KDLi7uoGjMyODZkuiFGdBZVkTvfRqmHIfIexjqLqvGfMJu4ZhazoAEPNTa9cj9f76Wnx3Xj2HANHqeLsInrM+l23aOy9SHXXzUXDBNNOwAyIhIyHGnv1ZoDDIx1YFXZ9wHIX41LXSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlTtrlRvGvm2BKy8LXrIP6QJagwjUHuHordad73H+jA=;
 b=fJ5lO5qx5p9sM+vCAYjytonu6fTM5RObXh0fU3EZAMXQDI+4frd6aeC6FbqtUug3fENEKsNjDakHGHkJ194gLRZIJUkeKQukTkhGfAorgL5UQqY+r9hW1MTewVvN9Mjver6t073JsF/AZrfCmflOj4315BX3MgGSqpZ/i7dKsjiUyQ/NdJxK8HDag07r3/9NGZsGkZm5qVyax5S2EarGeO406L3afs80lm7xGjWaUXT1KWNagFp+JCFb/yzHaHfH3elFPGaws2sVp4co054PCIkM0zCa5zi52yLw5fysjlTmMMy9mssXwm/4609KYcz40Uy8/9AGY9hckFHz2g23Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlTtrlRvGvm2BKy8LXrIP6QJagwjUHuHordad73H+jA=;
 b=fdaanyWrmg/cCnvg6NzxSwFdPilHxQL+f0L0RaJSrk0yf031r651sCcBjizcKw4E6YfrmwiVvc2BFXq1PdP4r3cNjI8Xpnb1DHlNME1zwnak8sD16QVLL+8XZaT77Yr4KTw4h0AQZ2EQjIqAXGRDafl9sW498ODwnSL33SSpA8DB6t61wSM9LhL+AyChYci6yCQhRulHiqvCrzxpCKrLTY5shdtcqT6URy1x/9VoAh9QEWOxVtdajTO11YbSatgsI5wOMl9tX//M23AKM+J+9nuT9gq5JVK1F9JWdyYNsY8xJ93nSimu0WNuLl3UI5j6eWjq/N1r3z3Naxovxins0Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Wed, 30 Apr
 2025 03:42:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Wed, 30 Apr 2025
 03:42:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
Thread-Topic: [PATCH hyperv-next v3] x86/hyperv: Fix APIC ID and VP index
 confusion in hv_snp_boot_ap()
Thread-Index: AQHbuGtk5GB1aHHJekOH82ARgcSlU7O7kW1Q
Date: Wed, 30 Apr 2025 03:42:20 +0000
Message-ID:
 <SN6PR02MB4157F5E0375016711820D2FBD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250428182705.132755-1-romank@linux.microsoft.com>
In-Reply-To: <20250428182705.132755-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8114:EE_
x-ms-office365-filtering-correlation-id: 3c2d57ac-184b-4abe-239e-08dd87990304
x-ms-exchange-slblob-mailprops:
 Z68gl6A5j2+rXb3faMtF+Xaa30Omw8BTNPOSth6AkLvEuS155CAOxPCHnp3OOWhCAkKsXNgHs7C/Di560fwG2dFGi3sPvVd/fJ++0FAGIgecJlwF37A7iLA5X+YppWU8dRtzioc9vRjOFxgT03Oel10mTaBCMV8kqAYzrF75fldsuvhz/E8Af4+O0Ed+ZLCBlZmP9JX6OEeNNtb3M2BQT5BVcRvb+qZAkprUlzzzxQeJ+HrgZFoheYREYUxmiOYTX4Ma4cSHtzLbc1OMXBaZYEKjgl7ikbksGDZ+tDpCR/sV/eD6VC4mmb7h5uBglJWnjAftyriVrTsTPTEe+hwFsznVCO1Qj32hOBcbTgJPRAXbhry+/A73CqEapHrC7lndh6TcGQlM0LMreQf71U13THgf82GMKIwKFCxHqU540WGwrGwg3m0BtTXacYiCPk+bhd7uw1tJgiY8X0Wd/8ePi6m61GQGZxnVbx1YwbyauChnREn+hgiH8uAEckGTeWIoYsMZThfKGSsenx+ek/Fidfxhe2QQGlguMq3E9cnvYsSAuj+qIpk/mg9EoSokH/NjU+HDqOpK5IP09NY2y9dAor23CFYnKfZE3aLF1P7ew7owxa/+WTOlq/YBl5y5vt0WJZE2ZB6ykwKjFuUz4E7EZXtOTLp6tSyztWIEGcLtBV0XDUcUZkfGBvJy+tGQ9Q2uT0rGqzInmccutLodF3Ch2YUr4CewzJeLF5weAd8EYQqnJXtj8Fw23aZGnzoDu0HzJARFZZwfDdfAhGcNN5RPzV6Po+0IzFcJZoT2Ke43FD1BwbSvqbgtQ5rO/1fHWxEC
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|15080799006|8062599003|461199028|8060799006|19110799003|102099032|1602099012|4302099013|440099028|10035399004|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?elPkzxjwu7kX5xyrBn78awwvVf/7e2vXjNVhGauClgsTCmDUKVFI5nktlkPu?=
 =?us-ascii?Q?Qr8SjYv4vHLqLNdBouP6pwtVkEO3mD/AYUQsT+v1hY29P3aX/BpBlQ9+ZoKO?=
 =?us-ascii?Q?7MlrQH9EL06NBoHXymCGbkvKRlwHmeYs+yuZgRNSfgAnnecEfTlnm1BJv6cs?=
 =?us-ascii?Q?m2f7ut0JqVwa+QCekMUDx1NVc8/gpMNAou/3DdnyVM34/32e7K6He4cqaEai?=
 =?us-ascii?Q?txMWf7vb68B/uWHvWc+8FSSj1R8XX8e97JVVSyYOLDJrzqnKmxjrSkzK0Ggg?=
 =?us-ascii?Q?xat7hU9sYvr7OyUNwe7ifOyvr6bm4MSkNvs/jHT45p8Q7yguwpCEQJTcTCW+?=
 =?us-ascii?Q?qSxbYWqij27gs5yxCbLspfZf2sLBsnZ/uMlxbkTllid4KZsVtUibzpLK0zr+?=
 =?us-ascii?Q?qQ6dcKgm9LzM3RZwTIcn2y1mXEuXzblgebBLknl+wOPgqgB6IMWau46JOZ4T?=
 =?us-ascii?Q?a2l4/QqV2/PJC5VKJaVB1zaUPzW6iQoE6lSBNZ35pXDo4eRk1zZ0BH+6SMNF?=
 =?us-ascii?Q?cIAOfbqNxjTHpXCm23UIZah1pycnIPzWkCuNjzustmTufLChpYLKw70HKrJM?=
 =?us-ascii?Q?Vmw4CZTpvfonWNtR1s3effyMea17UnuiopZ4OW+bI27lhrFJ1WMFv80q3gJx?=
 =?us-ascii?Q?7Qh3UkF9ohLvmsC5n2qjDaa8T8raBKqC7jyYrvHWfYc6WP6HbZbcmGHmN3TB?=
 =?us-ascii?Q?Q/CNMQo1aC0NrcfFKPOhDaUuKxuuhakquIQZop5CsmgOp9Arj4srlRG8EVz5?=
 =?us-ascii?Q?mljVxbhj5zaU3O0O3IMbDfWJfYeSs+5BEn741pGh/IBk6OEc7b2KuDQvmNes?=
 =?us-ascii?Q?dO4EdEX+pEMJnZq7RYnTqqWI+xY+9oCqZzX7hQk7MyTGtQYiSdp912SIQx1q?=
 =?us-ascii?Q?zAoL3HEWbFZkdwQCUi6SUG4ZoTyybGsh+iF6QPZBcAx2J03kXa+HJw6bTb2W?=
 =?us-ascii?Q?a85Q3KZTlvE/f9YsB6blBEqzUDR1JVRjqRKZrpcomVyvMVf8ZL4TxIJuuTaj?=
 =?us-ascii?Q?Tq5x+x6OLc4Wwrl2qy/Xn/hbpoixrC+S9G4mLV77HArhPITDBauCELgZFhXV?=
 =?us-ascii?Q?F5dUvp/1khrKPI6oxDmjf5KUYScG+Fnw0YuTSVxwoPZqUVXSf2vbnUDdf72N?=
 =?us-ascii?Q?TGGkLST05n61QMuoaVuP/D+pbEaCcsjizQdvCnSoPVnKaUqCyy7gJFubRpBJ?=
 =?us-ascii?Q?7+zeYhqM+QAxSPL50wtI0yclkWi750OUCDQC8fU3sOehR+zJWRGkCV25TQ1V?=
 =?us-ascii?Q?wPE3bwDHFHrFHLRe/ehAO3QAFA0othueqEwJGl1aOYLWzRMlEeN9wtTXizig?=
 =?us-ascii?Q?s/QOKuD7HrBNFF3Z32vhr1a4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0sP9ZEUg4Wuy8cBF6kA2nTzqCID9SLcADlKqg+1UUb3TVRaEgCefjbPpHrEo?=
 =?us-ascii?Q?KLwv0ghCVnjwacLjgmlSTLhGHQoNezeq+jh6DzMQaWOVL/AZJzrQgt2RyOI6?=
 =?us-ascii?Q?8DgoSAgjhLTWyZddZP3YdpmNuvVak2GuD2YMY+ZdDpNRe92veRwYAVA5S7b5?=
 =?us-ascii?Q?85eRkd77dhHH84WcH0mto1bYthNcNTed6SEN5iDUly6PkNZpjaRXDhXXYfRw?=
 =?us-ascii?Q?Nn8V5x4aKUfqZW4+CMQoDRRJqfhyYaw2wj6/8xBe+7Vx3vGt60H3SYz2Xyov?=
 =?us-ascii?Q?nlQ+4rlFw/2uRJME1Jckdn0NBUrsrsV4rT7h+ux7tpZ34oq5W4atypKDL2KG?=
 =?us-ascii?Q?iECd5nI0+Z3TuPibX33kW4WoWqTTH6izcEhpczib0L8AflhDETBfwfn0PbJT?=
 =?us-ascii?Q?beeuoPk4qDeKX3Wa5hlmwdUrjMk9GeL2Vk8jNa5307ckRVeadd4KvcN3vK2X?=
 =?us-ascii?Q?waMYctmmT27y8RN3YaVhWgHGOp9JS33qwlYio55LUKNUqSfY7Q2Skmm3kUAQ?=
 =?us-ascii?Q?GufOF/sCIAJVmooY9A9eB2MwtIg2jY57XX948KfJanYnxU8T3U38mzzT+0H9?=
 =?us-ascii?Q?WN8Tc5MF5PlWWMWeHmmwIy1Mf2t5OArID1tHArR+XdTvt7Wx8NceXtuCiXWv?=
 =?us-ascii?Q?+T3G3kpXnA5J1YEeaWyvlIRzDCgFjw8nRSk5alOUbXGqZeSwHK4JqV/dVGoB?=
 =?us-ascii?Q?d3Awn6qCXGYz2G/9NMAtLf/FIhWplynAWWUsho849UrXgT6/eOHKCaaOYEhz?=
 =?us-ascii?Q?WuEiyhvffWhH6IjPAGVwsp4Uxx9WHm+FimBTucfMu2FcXC+KlWFxQ96+FIkD?=
 =?us-ascii?Q?iSqTtADfmBV3OkSBTW1dcL+B0BN0g+ifZYYjKo+HGX2riXpoEFgkd43E/LrD?=
 =?us-ascii?Q?NWsGcdYrJrXunp1bHH1OebNCEB8Z3d0qCxoytDXkOYBG8zmtxSOPJSXdjNt2?=
 =?us-ascii?Q?qhxdYPrAvK4g3nIrwbsO5dtHEzWaJg0lv2I8l1kvtAIH7q/F3LN6ypX3Mpy+?=
 =?us-ascii?Q?SoAPMA4JPb9q/ODBssQkvd7obIOTJTIsaoXz0OgvQDlU8VBpnopWI5oHGq+G?=
 =?us-ascii?Q?Cpx9MctiSAM4nfoiYy1yE2d12mZpqN7t5CNrs4vGYHhF87umete8JY3dPlmA?=
 =?us-ascii?Q?+oYCq931P2bGEuv/fIXSyv49UaYPGn5JRb8rMmV3CzbFimQBxQZJVQf+WlDg?=
 =?us-ascii?Q?VykLn6cK1UINI/q8kUwIQ2bhGBPb7VnmAvkS5T49BeErZdrs1jh6cgvVZ7s?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2d57ac-184b-4abe-239e-08dd87990304
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 03:42:20.6444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 28, 2025=
 11:27 AM
>=20
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that START_VP hypercall but passes as VP index to it
> what it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
>=20
> As those two aren't generally interchangeable, that may lead to hung
> APs if the VP index and the APIC ID don't match up.
>=20
> Update the parameter names to avoid confusion as to what the parameter
> is. Use the APIC ID to the VP index conversion to provide the correct
> input to the hypercall.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
> [V3]
> 	- Removed the misleading comment about the APIC ID and VP indices.
> 	- Removed the not sufficiently founded if statement that was added
> 	  to the previous version of the patch to avoid the O(n) time complexity=
.
> 	  I'll follow up with a separate patch to address that as that pattern
> 	  has crept into other places in the code in the AP wakeup path.
> 	- Fixed the logging message to use the "VP index" terminology
> 	  consistently.
>     ** Thank you, Michael! **
>=20
> [V2]
> 	https://lore.kernel.org/linux-hyperv/20250425213512.1837061-1-romank@lin=
ux.microsoft.com/
>     - Fixed the terminology in the patch and other code to use
>       the term "VP index" consistently
>     ** Thank you, Michael! **
>=20
>     - Missed not enabling the SNP-SEV options in the local testing,
>       and sent a patch that breaks the build.
>     ** Thank you, Saurabh! **
>=20
>     - Added comments and getting the Linux kernel CPU number from
>       the available data.
>=20
> [V1]
>     https://lore.kernel.org/linux-hyperv/20250424215746.467281-1-romank@l=
inux.microsoft.com/
> ---
>  arch/x86/hyperv/hv_init.c       | 33 +++++++++++++++++++++++++
>  arch/x86/hyperv/hv_vtl.c        | 44 +++++----------------------------
>  arch/x86/hyperv/ivm.c           | 22 +++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  6 +++--
>  include/hyperv/hvgdk_mini.h     |  2 +-
>  5 files changed, 64 insertions(+), 43 deletions(-)

Thanks for fixing the terminology, in addition to fixing the bug that is yo=
ur original
purpose for the patch.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

