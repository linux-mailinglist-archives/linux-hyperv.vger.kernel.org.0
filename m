Return-Path: <linux-hyperv+bounces-10350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFQoN59Z6mmgyQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10350-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:40:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFF455A3E
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 19:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDDC23001A46
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797233A8721;
	Thu, 23 Apr 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OBWY9rep"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76542AA6;
	Thu, 23 Apr 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966029; cv=fail; b=tNsQcDe1NFmgmufGR8OaWBOL7JY/77zwitWHERCh06O0OYwf8YXWtHg+EwyCJJCvFD0rza8QhofbvpMdjE+dnr43gq/T4d2mc33i3B1A49hbR/tV0vGJsfqz2Rw2IvwKrQgMJzEzlXrra8L2zN5dot5TGNFEe9rQfJxKQwMSIns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966029; c=relaxed/simple;
	bh=/sv4lrs13uT4GQVVWuUKfM8m1p4Z9Syw2PolAzOt9Yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXw4IYOSDzkouUWKfSgv0MrR3c89CNCWy1ZL/n+YxxOnmRsSmY+BWw/lgjxef1e8qSlzSN7xjkHWjKy79XC9PE2Ik8Gf/giNelHeCed2duVdJpjL4Dp496of6SGO2oCctT71tysbBmpCRAaGu7OcQY6/qUFOzO/klCNrgFZ4yXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OBWY9rep; arc=fail smtp.client-ip=52.103.10.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzEG6oh8+vHVkU+raTUvCBfsy8RcEnPFSAxdybwxTkFIp81dM70Cz3L+6ijmB8QUA6E9+8PgnWyh+1BOblT+0+dOGNRExezDbgyv3JSs2zt5y32srDhztQ8kyhYZYDXZ5Kq5snJ0durN+4eGoIZX3YVaA/P0qAB0lV1IN/d+ogGvDPzs0xCdYEd3PPPg4/VErtYAFA6JpAJHctduhgBJDSFclbUTAKvQC0XfnvZPs8DKyM5jVpHzzTf/2lJYG73mHlnNaZPw4DwJ3l6s2f1NZK0tNFwSLpJmx60GBwRvthAaqO39JGKskPCFq/fImA7wpMVWu56W+WElaifc8DT+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC8ON2BJJMGxzieX13bEW4dqO5Zq9Y+9YyO7gXZExqc=;
 b=OYIW6KuobzvjAofHBKw/8VmNnLjC1ako14UNXuSSqyjDlLjg7mg87QddCaKocf+b63hmBcucQ63Qv4OhCRIyYO8BsbJjrM7BBEXuDnNVybv2ORVWLMOVRAy+J1Lwo0sUybPB4VW5tMGVHQM74mKpvDtpZXjbFGrVO5YHK5SNGTW9qKn+NTAEQxUW8KmOsJxn3Ykzg27nCvm3Xxng4DSHZu6Q+/g+uuE4s/p2bKsfb54FmkN8EPIgYmoxixp5gGzKfs2Lxa6XxCsqq4D17v3RXZtDb7f5GfXGW3mD37ZkL1GbcXC0IbzRlWxJtyp6k2Gq5ofBQrTiRoZIB3FgeWXF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC8ON2BJJMGxzieX13bEW4dqO5Zq9Y+9YyO7gXZExqc=;
 b=OBWY9repu7fX/Fj2S0YXSPWgvSQ+qm4GZSGhjvIbIhJx9zJNmg0OZJG5kRqDzdYt/FYutYysdxxec05VjAfd6dqygSY6Fa4L4X38x+wnR+tZ5NnbpIoRO98bNKMY/JL0OlF+KUb3OLc0oRb04pPUaKvrvb/vfEQLFMYkN9gmBbWHkh8ElONSGBg4CT4278LR62rhr4Xi4zgVKSL9GjjTcjZRT4QCfnmLajzYdaCG2txFQNIu3M2Oj9U5pi0kUaDqQK5cZNAe3nD9DjUcKVepnb0o7Az0VikG67Zx6wbMpUEe/xMy93rMtok+1HwFuFGCtTH16Ptlx1egHu2z5Mf5yA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6674.namprd02.prod.outlook.com (2603:10b6:a03:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 17:40:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 17:40:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving fb_mmio
 on Gen2 VMs
Thread-Topic: [PATCH] Drivers: hv: vmbus: Improve the logc of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHczc/fn1PdG2gkFEeUWQdp0QjV5bXs9OVg
Date: Thu, 23 Apr 2026 17:40:25 +0000
Message-ID:
 <SN6PR02MB41576A849B6C4967622B4BA8D42A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260416183529.838321-1-decui@microsoft.com>
In-Reply-To: <20260416183529.838321-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6674:EE_
x-ms-office365-filtering-correlation-id: e18186ee-8a4d-4cca-479d-08dea15f66d1
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|19110799012|8060799015|461199028|37011999003|8062599012|31061999003|41001999006|19101099003|55001999006|51005399006|12121999013|13091999003|10035399007|4302099013|3412199025|440099028|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wxz087xo0OE9G98sxYpkTzjvvB/lHbi5aKQz+BdOBZcM6OyNox4NiEFTCUOP?=
 =?us-ascii?Q?3RDlrRkZkAmFC1sYo6+MpfIv1Tq+AjWZiKCJucV9kWMghW3Bx81CSExg55IH?=
 =?us-ascii?Q?kH+N4CoJSz4OabqS3ZWJAJrKW0vSj2D3FyvKQBfCClUjB/vrkGrAlhg/LYn+?=
 =?us-ascii?Q?O21uKjkCNjqvodAnCzpBIQnN5M1aMQgbNtV66jGBZVyNLHRuBrE3jzYg+tuw?=
 =?us-ascii?Q?2GcQdyT4ih2PaJINYup2eJeOyGy/+kB1TfLz+MKSm1DLgf4G3D7MBnUB4qNF?=
 =?us-ascii?Q?xqHlKUhF9n+4iypbmCEtgEkEa1WMDHzQAkGcWKgBGfU4TXLwLnLCpLzSrQI6?=
 =?us-ascii?Q?M/lCvFB6ngj9colnxM4bD1DKnyr2DlkgJcQ5nzkFT18uyvHbgzuIUoxoMyb2?=
 =?us-ascii?Q?xwxKhWne1yADka67c7UbY1b0SdRDBV5oG9accJohUuTXfbHMtazGQ0/RxLrE?=
 =?us-ascii?Q?cl8Utwie7HTYExJyTN1gFB11KEJBGb0ILW7Q3ehALdVM9N5QaDJJbWYhP5Sk?=
 =?us-ascii?Q?cB/e7rQrnY3+3cV1AOTEXkz2eH30TEnpqZlPVcO5iDU8UsPnB2VEyavZqngE?=
 =?us-ascii?Q?QzNbzlZNd2Jkjbb3UOM6lf0AnjeU/rQeqyk1RiJXKRhT1iPVCPQ+Y4L9Q7kg?=
 =?us-ascii?Q?G97eo3bLrSesvHlJZnUw3f6A9+0OH/gmso5Vx/SHhMrMcL/jgwtpeecNyzG8?=
 =?us-ascii?Q?7irzdIWCUzF2newpnkevoi8vEaAQ3oaFjzAy22HHqTPbogAUxzZpWXDq7/8X?=
 =?us-ascii?Q?gT1CoHL060/9jbUcrL1k/AdDFN3k+Bht/xUToE0DTTXZhPdrh+f1qvNGISDw?=
 =?us-ascii?Q?L1sEhNkPhvutYPvedM7pLMQKDKBs6g2ZDBtGM7c9tjgCEp/XC92zcGPdIvk7?=
 =?us-ascii?Q?0EvuoFoUKw8ILLzjmvmq7c8mr45t9GsDQEYUQUKVvtPrFTjXP36+SaIivPVT?=
 =?us-ascii?Q?2b9/7BTX5oNnBqCuPazIY+MJbatZ36hHQpfm4++YhJzcPAicKuBZ4NPdGzhb?=
 =?us-ascii?Q?rL8VOIU+eHemSfRubKirHTAa1d6eISGNzn6k9dzKlRIomJFa4xFZNyyIICVW?=
 =?us-ascii?Q?fHvhauVgpAHqVqZv1XWAoMdJIr79m/kTPBPqHqfT4azypsaHyDYeq7SwfruI?=
 =?us-ascii?Q?eL+QN8oQwayR+cI8jYErGdEUwK23s8pIY1r+Udhd0Tq4nTN55WfA3uRtwjWL?=
 =?us-ascii?Q?HWFBD0pU5rfQn+O4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kUmwfht/StW/ECp+4Z7F1YzWSfooSjQmR2jTB53VhBvF/j1R4qt9P6CMOAJG?=
 =?us-ascii?Q?f/eR5E+ufq7EhETcpdlQEf1WHgeRoYuo/FJGzQ+p7XOZQm+Ony0ANDZJ/RRK?=
 =?us-ascii?Q?AwzcjWtJKeY5edijE22qNTdHJGnuJMIS6J2Sf9DAIWgWgb+4DBzgyljnvJSW?=
 =?us-ascii?Q?nCSij5QdtSVTyFQ5m+Tz840KoQFq7PCpHD3spnDWCkVRhi3WUH/lUVoCR2gG?=
 =?us-ascii?Q?MYHLsXh9KxEceTqUgST2EeWD0HR8+eYIlgLH2aiGeqp4/+RBb3UWn6A/DEHE?=
 =?us-ascii?Q?gnoRRV0DVfWqnp3JFgJCi/sCPVqQ0T6NUACmVXB0GcLXNk4ff0Y5HSJo7vtw?=
 =?us-ascii?Q?/MmPNuJg+YCXT/wro/2JwIM2D/RN+De1nPpW+oVXJuJeq4wQYdYPP1OR/t8N?=
 =?us-ascii?Q?DW71DrCenyWw9FnYt2k35OwtgXOSzdYrn8lSCJqT3co37KTnnZyADWxCk4ua?=
 =?us-ascii?Q?X4vAd1Lh6dRFM+q6Uy9EbFVF+zq+ufv7fwcvb2ZjoWekquKCWRws1jdUtDRe?=
 =?us-ascii?Q?5yp3T+6U/nAljQK4CjhEngLjsabVzKfAaHdlk3x0SG4ikRZSxyvG5LXi3LKa?=
 =?us-ascii?Q?xOyNN26QTbSQeZn4h6iUaPwm2HknCgM/Aqj5Hcu20a2X7m0Bjesj/w4ilyau?=
 =?us-ascii?Q?vAn/OA4XeRz84Pw5z/Xmv7CtrszHDlgrq57fNeZs6Ky58jMEoILkmgO3G5hE?=
 =?us-ascii?Q?1EcqtflRKdpnzdYI6tvC6adDYuzPeSwLH2wGSWgX5Pw0SelqcVjABX4Y3Kmx?=
 =?us-ascii?Q?/vZRLb+AevxmbMPuAYfznyN6s92d1kvbIYFara+oBCaeRkpZAbW9cCHZxWko?=
 =?us-ascii?Q?1D9hknVIemFg81cGprCqrcR+gr19/HCUbgS5bfTcBvha0JlI+jfSpJB4d8wi?=
 =?us-ascii?Q?SzbltNmaLwBuMzfJ8n0pHzciD8pVIf0Xu1YePWYJyi5ii2MoXe+piZGTYn0K?=
 =?us-ascii?Q?IgagM+MPmnmlYmrhsWZAVR8JZf8mRZGg2kYsdvdjv0xHbzKTYKfE7QAN1xDD?=
 =?us-ascii?Q?HuGun/ZvawI0XLRicR7gDV9X23G/VVno8yQb4SEyQoRSAuyavqteKIVQlXQx?=
 =?us-ascii?Q?9U6VRpvJ9dLxQApvFqrbojl5HGsvzu5cYBwP1xLt9f1fGr+q2ukvx+m1yV/e?=
 =?us-ascii?Q?ATSkE0ux6w7CnYZC9wLWzbXCLEMQoJ9hhQdomnJFDNdXfJQzWnedHJkPKwIg?=
 =?us-ascii?Q?kh+I6ozjdR69OWhmrBGrZ2QfZjvK6N9gIgt2WbppnVS8qsWcygfYk/OI10hQ?=
 =?us-ascii?Q?E9fabFWdCt935G/426JGMXMsNhxybMtL7B12t52eBLmWVftuidtQVMOnQGak?=
 =?us-ascii?Q?4GtNQr3zjfM539uPGkx7+3CkjmGAhrIiolOTRTkx8OHV0BAUtW+vZdDSuZ9a?=
 =?us-ascii?Q?DTQJdXY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e18186ee-8a4d-4cca-479d-08dea15f66d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 17:40:25.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6674
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10350-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01FFF455A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, April 16, 2026 11:35=
 AM
>=20
> If vmbus_reserve_fb() in the kdump kernel fails to properly reserve the

This problem has wider scope than just kdump. Any kexec'ed kernel would see
the same problem, though kdump is probably the most common case. But the
discussion here, and the mention of kdump in the code comments, should be
adjusted accordingly.=20

> framebuffer MMIO range due to a Gen2 VM's screen.lfb_base being zero [1],
> there is an MMIO conflict between the drivers hyperv_drm and pci-hyperv.

You describe an MMIO "conflict" without giving the details. Is that
intentional to keep the commit message from being too long? It might be
helpful to future readers to say a little more about how PCI devices must n=
ot
use MMIO space that the hypervisor has assigned to the frame buffer.

> This is especially an issue if pci-hyperv is built-in and hyperv_drm is
> built as a module. Consequently, the kdump kernel fails to detect PCI
> devices via pci-hyperv, and may fail to mount the root file system,
> which may reside in a NVMe disk.

It might not just be pci-hyperv that conflicts. The recently submitted
dxgkrnl driver also does vmbus_allocate_mmio(), but I haven't looked
at the details of exactly what it is doing.

>=20
> On Gen2 VMs, if the screen.lfb_base is 0 in the kdump kernel, fall
> back to the low MMIO base, which should be equal to the framebuffer
> MMIO base (Tested on x64 Windows Server 2016, and on x64 and ARM64 Window=
s
> Server 2025 and on Azure) [2]. In the first kernel, screen.lfb_base
> is not 0; if the user specifies a high resolution, it's not enough to
> only reserve 8MB: in this case, reserve half of the space below 4GB, but
> cap the reservation to 128MB, which is the required framebuffer size of
> the highest resolution 7680*4320 supported by Hyper-V.

As you noted in the detailed discussion in the other email thread [2],
there's a Gen1 VM case that this patch doesn't fix. For completeness,
perhaps that case should be called out in this commit message.

>=20
> Add the cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) check, because a CoCo
> VM (i.e. Confidential VM) on Hyper-V doesn't have any framebuffer
> device, so there is no need to reserve any MMIO for it.
>=20
> While at it, fix the comparison "end > VTPM_BASE_ADDRESS" by changing
> the > to >=3D. Here the 'end' is an inclusive end (typically, it's
> 0xFFFF_FFFF).
>=20
> [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA=
1PR21MB6921.namprd21.prod.outlook.com/
> [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA=
1PR21MB6921.namprd21.prod.outlook.com/
>=20
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsof=
t Hyper-V VMs")
> CC: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index f0d0803d1e16..a0b34f9e426a 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -37,6 +37,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
>  #include <linux/export.h>
> +#include <linux/cc_platform.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -2327,8 +2328,8 @@ static acpi_status vmbus_walk_resources(struct acpi=
_resource *res, void *ctx)
>  		return AE_NO_MEMORY;
>=20
>  	/* If this range overlaps the virtual TPM, truncate it. */
> -	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
> -		end =3D VTPM_BASE_ADDRESS;
> +	if (end >=3D VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
> +		end =3D VTPM_BASE_ADDRESS - 1;
>=20
>  	new_res->name =3D "hyperv mmio";
>  	new_res->flags =3D IORESOURCE_MEM;
> @@ -2395,13 +2396,36 @@ static void vmbus_mmio_remove(void)
>  static void __maybe_unused vmbus_reserve_fb(void)
>  {
>  	resource_size_t start =3D 0, size;
> +	resource_size_t low_mmio_base;
>  	struct pci_dev *pdev;
>=20
> +	/* Hyper-V CoCo guests do not have a framebuffer device. */
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;

This test is testing feature "A" (mem encryption) in order to determine
the presence of feature "B" (no framebuffer), because current
configurations happen to always have "A" and "B" at the same time. But
the linkage between the features is tenuous, and if configurations should
change in the future, testing this way could be bogus. It works now, but I'=
m
leery of depending on the linkage between "A" and "B".

You could set up a "can_have_framebuffer" flag in ms_hyperv_init_platform()
if running in a CVM, and test that flag here. But I'd suggest just dropping
this optimization. CVMs are always Gen2 (and that's not going to change),
so they have plenty of low mmio space. And at the moment, CVMs don't
support PCI devices, so can't encounter a conflict (though conceivably
some new flavor of CVM in the future could support PCI devices).

> +
>  	if (efi_enabled(EFI_BOOT)) {
>  		/* Gen2 VM: get FB base from EFI framebuffer */
>  		if (IS_ENABLED(CONFIG_SYSFB)) {
>  			start =3D sysfb_primary_display.screen.lfb_base;
>  			size =3D max_t(__u32, sysfb_primary_display.screen.lfb_size, 0x800000=
);
> +
> +			low_mmio_base =3D hyperv_mmio->start;
> +			if (!low_mmio_base || low_mmio_base >=3D SZ_4G ||
> +			    (start && start < low_mmio_base)) {
> +				pr_warn("Unexpected low mmio base 0x%pa\n", &low_mmio_base);
> +			} else {
> +				/*
> +				 * If the kdump kernel's lfb_base is 0,

As mentioned earlier, this case isn't just kdump kernels.

> +				 * fall back to the low mmio base.
> +				 */
> +				if (!start)
> +					start =3D low_mmio_base;
> +				/*
> +				 * Reserve half of the space below 4GB for high
> +				 * resolutions, but cap the reservation to 128MB.
> +				 */
> +				size =3D min((SZ_4G - start) / 2, SZ_128M);
> +			}
>  		}
>  	} else {
>  		/* Gen1 VM: get FB base from PCI */
> @@ -2433,6 +2457,8 @@ static void __maybe_unused vmbus_reserve_fb(void)
>  	 */
>  	for (; !fb_mmio && (size >=3D 0x100000); size >>=3D 1)
>  		fb_mmio =3D __request_region(hyperv_mmio, start, size, fb_mmio_name, 0=
);

Just above this "for" loop, "start" is tested for 0. This patch eliminates =
the main
reason start might be 0. But I guess it's still possible that the legacy PC=
I device BAR
might return 0 for a Gen1 VM? Or you might get 0 if the pr_warn() about low
mmio base is triggered. But I'm thinking maybe a pr_warn() should be done i=
f=20
start is zero.

> +
> +	pr_info("hv_mmio=3D%pR,%pR fb=3D%pR\n", hyperv_mmio, hyperv_mmio->sibli=
ng, fb_mmio);

Outputting the above info is nice!

Michael

