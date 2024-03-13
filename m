Return-Path: <linux-hyperv+bounces-1745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D871887B1A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B71C27D7B
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E476087F;
	Wed, 13 Mar 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A6OqNjPU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2160869;
	Wed, 13 Mar 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357147; cv=fail; b=VCM/qN1UROltH+yvgapH1xaKp4b2fDRejphXPhrrP6m/KWetOPzsY1tNL8245n4NQpy2RfYe15P5sTtWGIrZr2c9NnRG4EPKrCMiZRCsuNSs+v6fvIq1s/4M4xkyEyNNv8olOl674IYH2VfSb+AUtVcdZ/yJJjJIzTGrkMlai8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357147; c=relaxed/simple;
	bh=hNeCYPsRMSHf4VMHt4T7PbGzuN0us/3ABGbdFhyo8B4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSs2gtUNELZFnIFSAFsyqrEdlSvN2uqTk/uiKppMQkeoTMAafPWs58z/VFQ5mEgnNhZzQfpsfsjp7gRb1V//l49i4lk2/yYmuRqZRzxwccEj9ORohp7zJCXJ/6S6Zdxg52qLleyDjkKyzamTezI2scjo21MBXy49JMHXn99a1L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A6OqNjPU; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mcge/eOub5LM6F2OLFiq8PugXI7w9x6+3Xjh9i8v4Ws2qGSw4UcuYkaLDtYn3zKIF46jAJXXcCubVnUvipdcLnKkGSDDofTtDtqqjxpAk+nw4Tuuu27t0TffSlNP2Ev6G6B6DAJf2FHStAhKnDAmCpks+tTpaEQ80SKaKma2dilFzqRoIB6LEofYzupxuV0l5NTPjXfRRaySj4W5H1sLq3AGaEdH9SatUgYl3+OGiBsPo82CPOtaXtSSZBG9ZAbzD4eXjweueUTA4cvXZ63EbaP8nDbgrTlcE9YKdtCriAdBzHIchzPV6bYkMYFhUPeVm4JVVk3ABS1KRlevsEzs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb4si+r8Yu3u3IsPvEcFakXbnJfP63ThJDQY7pNei9o=;
 b=Gx7ZWIE2Zd06/zKClCkxXOWp0ZdmoNmFOVs8x2zj3hB5+WsCY+9sMG96nMXEFF9HwAHzTT9Cpn/qtD3GcZSNKf+dVEptA6hQSfX4ydiBNBc9wstYDu0gLsjnp15PO/WktQ7ZKc9kR1O5QhZfsX+333tF9H2iWEA8SdL+Zz84eDDNsqPRl2CVTGVzWjJj7trI0XMgF/FXZtzEqIpdH46hOfP/tB0vUEuDAtljFIxJtjuSqzaI4ftR4178OcIZeXTfou5xFSSl6p2KAaU5EH9UUqpgz0kR9poSpDPqoOtM1VMslaXqGjrdA9fWbhspk1zlUwNdcjHFRjKX30Tome2+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb4si+r8Yu3u3IsPvEcFakXbnJfP63ThJDQY7pNei9o=;
 b=A6OqNjPUMt0noWSrM513J7UwYF3xJqVWsxiHzzZj4KzLTFdfg7g1iZnWuSwmda8MeGABGJ1YkY0A6myta/I1AECTew0YBxHflCpZhc6spmxirTFbcG3fOq6CLA2AeAHbO+z5UU7UTEpkIarJya7KVrrlfBGSJwnPShimIxo+GVI=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by PH0PR21MB3026.namprd21.prod.outlook.com (2603:10b6:510:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.5; Wed, 13 Mar
 2024 19:12:23 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Wed, 13 Mar 2024
 19:12:23 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 4/6] tools: hv: Add vmbus_bufring
Thread-Topic: [PATCH 4/6] tools: hv: Add vmbus_bufring
Thread-Index: AQHaYcvMTJRAmQtKYEuIgdJTlJTrs7E2LsEQ
Date: Wed, 13 Mar 2024 19:12:23 +0000
Message-ID:
 <SJ1PR21MB34578EF2FD0F5BA29D0CB95ECE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-5-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708193020-14740-5-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|PH0PR21MB3026:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MdJCDvv9dzZBIIWII3rjk7JgmLF6TRdfjPEag6CpuqwacEhB06+eT4DUGJvsv5nigNdDDQZYPKM2m9gCzfuMgw/e/xDAd9qDmgubrbZ9dqu+0BeUs1C1e5L8TlNYWmfdANzDkRUrKeBJ9PrErAKigiB5aA4en2gQio3GE84Jqa6h1uQoyCVKFmjiTMyH464zSx8MU0Z/99FV/o0Vd5zv17rVrDgOR6U8dTj53AvXuj8aQkXmmwuhUTEtFavZyI9VD5qwrmy7O3S9rx6s3BHgwwOBOGawMJSoZnkH+ervCWjyHPQc4DO8aE56FYBVVIDRKE8Ahh21690XG8GepdLmxMXGBn7o/JFrucoKKOd3vRSJfV4Mjecy4zzW5AnpH6XJhnku3QpaX6MSrmickI5/fPkVU1wqRginpQBObqRuGQCdERO38esoVoDqYk7wx6zj4BX4WZFa5dgls3wq99DPIfZG5MUtcf+m0JWo5ieH5TuPMhB+kFWIV04zcainLejsaqVo+e8YrT5pNM4RFnHuTQaShs3HkTGQVjjatMFoqsA7P0M1jnSt/Tz6ZMZzrwZ3SlPVSoyvXQUCszq+GmDkNNSmrEJ7bP3bHgQ5XCJMUMiUFOal+b/68NiPQpirucSqbsiLy9PJHVgLSjGzaUcHt/fLM8PmXkG7aAQnmEYJZL0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zRTdhH9lrGb49sZQOiiC7rPQ3vEjRhN8f21d5tjBYC5rMTnR/tFxvi+mPsZf?=
 =?us-ascii?Q?xfZ8e0gCg4bFqOFnW+0XOiAyMtyjpNl+QeASP7lzdonTyfx+3jo1z/G7F9Xc?=
 =?us-ascii?Q?Phjcn6boxf6kcTr+NiwZ60B1f+9T9FFrng241MldGM7z780znKe/z5iHyfvR?=
 =?us-ascii?Q?bx5Klu3mrNUQAyXbKcaa6v4sHpf7xBzzliTEUaELWlBLKPOzTFQr3C9oybeN?=
 =?us-ascii?Q?vjsYCN3vgeWGkQDJuc4dcrdU57VEgpJtSQB9E1XU3ySLuo5z/w01O6T7ePCj?=
 =?us-ascii?Q?iBUjAv5IsXUng6e41M1b90KrQUusYAEX69n4gU8tIuMTTV6zUafQXcf+ElSO?=
 =?us-ascii?Q?hTq1esYd7SzgtYaflY9GN2vPbjc4WpZWhb3r90czpEI4vw/lAQ4+w47/Wq5C?=
 =?us-ascii?Q?O+sJgfOQfVxUc/tOpF5wi0eE6dRnldewr05lV42PkdDZ0c1xKqQo1RumQfvq?=
 =?us-ascii?Q?jvM9UAd7J0jFj65RHo6p1aFzHj3PuUJG4MqJtroBaw127Xmv6lusZKxoQ2W2?=
 =?us-ascii?Q?fKYY2nQeim+DadNdibgnGTBC44R9Z0VBFbi/Hj+0epitLq817vOGTgXbPcpX?=
 =?us-ascii?Q?cWNDQF4LP1dSd4IH/MM2AK5i7bd/4FioxkafDytfCZjrQ7sVon6kk7ecoI6s?=
 =?us-ascii?Q?uA2Mv8PshmUyoKVuaKz3g/SFoXq+Rafqya+LS8hxc1yOJw36WKmgUoy/a4I9?=
 =?us-ascii?Q?WGx8Cu8IIQHL5iroM3JoyQ4shqZJ5k2AYgu/rZqRTgBSuGf+AKc+iSchgkwL?=
 =?us-ascii?Q?nn4QNCWdMvL0GV7AbkQhiECUb0kPEhc4RmpV1YJX8p72DxMhviaPEmqtM6gz?=
 =?us-ascii?Q?rGtxMTcZ3Uuxtx6bb/So/t+IN+NKTpfRcI4JfNwiAm32WraaUC8diCQ3Tf2o?=
 =?us-ascii?Q?LG/xne3xlyduwXmfnl9JJ1OWt+VyxS6tYmEdap2f8kWANiHR0kFBpIrY9OKW?=
 =?us-ascii?Q?awHsMdPPsSHB86ALYoe1wT0ZEL5er+l3W1ioej88Seu0OHiUtgimo46o3PRP?=
 =?us-ascii?Q?J4KGlEnNTfaIL8ZKVba1akRA5zTrEUQTEBbdap4CXmJiE4WG5jMZSZArQiRm?=
 =?us-ascii?Q?bKfJ8CS/4+iCEjmk1+IpHWZdX5/tYHWP5glGsFRFYeQR6sM90ng8zMwoC5bj?=
 =?us-ascii?Q?75WpIOlxIFc1swqma2S7p2rEI5wvVeLW6PikUHCCXBaEPAhc1/CRVrtQW6Yy?=
 =?us-ascii?Q?kPWg1OawocJ2OJA+gSgS/AnHlWDobRV2mr4hZRMbS0f5dMMOi8faT5itDVa3?=
 =?us-ascii?Q?yl8D0NX4+q9EI3zh3W+YSTM2iapYUHqUF0HMl9ahpgPtwFxJhRZLpKhbi9A3?=
 =?us-ascii?Q?FahEQkuv+nF6VOiwDkmarYSrqWDU+CWRsIJ/xybquAfHQKQnN0qttRPhZL+6?=
 =?us-ascii?Q?l8yhlU/UyAAXbISGOwNtJhz1tR7D61+NMoBgEtOcEzz/AHQBP0XtzD5tPifs?=
 =?us-ascii?Q?zEo9/5oxVKhACWFgZi6HPnsNs5378SFy1iPRKACoDQYI31hyR47yF9LWVMF5?=
 =?us-ascii?Q?wdch6bpwxv4UICoZVcFbM69VTjzy4UAKKK59ZvnJK5Y3GyD8fC0EOGXkyGfp?=
 =?us-ascii?Q?kgwBtnwXaDM0+VYRtZukGT1EqA0rctg4jclzdeqL?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a43b57-07a2-4af5-ee8a-08dc4391837e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 19:12:23.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngfyXcrZ/Bf6CL/m3eoVBeWCJ81jhWh3kNJ9Y/zQZCYEvjEDO+r49uqYemuMQdyHPIEALZ1sjIFpsvU051byBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB3026

> +
> +#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
> +
> +#define	rte_smp_rwmb()		({ asm volatile ("" : : :
> "memory"); })
> +
> +#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
> +#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((align=
) -
> 1)))))
> +
> +void *vmbus_uio_map(int *fd, int size)
> +{
> +	void *map;
> +
> +	map =3D mmap(NULL, 2 * size, PROT_READ | PROT_WRITE, MAP_SHARED,
> *fd, 0);
> +	if (map =3D=3D MAP_FAILED)
> +		return NULL;
> +
> +	return map;
> +}
> +
> +/* Increase bufring index by inc with wraparound */ static inline
> +uint32_t vmbus_br_idxinc(uint32_t idx, uint32_t inc, uint32_t sz) {
> +	idx +=3D inc;
> +	if (idx >=3D sz)
> +		idx -=3D sz;
> +
> +	return idx;
> +}
> +
> +void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int blen)
> +{
> +	br->vbr =3D buf;
> +	br->windex =3D br->vbr->windex;
> +	br->dsize =3D blen - sizeof(struct vmbus_bufring); }
> +
> +static inline __always_inline void
> +rte_smp_mb(void)
> +{
> +	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory"); }
> +
> +static inline int
> +rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t src)
> +{
> +	uint8_t res;
> +
> +	asm volatile("lock ; "
> +		     "cmpxchgl %[src], %[dst];"
> +		     "sete %[res];"
> +		     : [res] "=3Da" (res),     /* output */
> +		     [dst] "=3Dm" (*dst)
> +		     : [src] "r" (src),      /* input */
> +		     "a" (exp),
> +		     "m" (*dst)
> +		     : "memory");            /* no-clobber list */
> +	return res;
> +}

Those helper functions (rte_*) are difficult to read for someone without DP=
DK background. Can you add comments to those helper functions? Maybe just c=
opy the comments over from DPDK.

> +
> +static inline uint32_t
> +vmbus_txbr_copyto(const struct vmbus_br *tbr, uint32_t windex,
> +		  const void *src0, uint32_t cplen)
> +{
> +	uint8_t *br_data =3D tbr->vbr->data;
> +	uint32_t br_dsize =3D tbr->dsize;
> +	const uint8_t *src =3D src0;
> +
> +	/* XXX use double mapping like Linux kernel? */
> +	if (cplen > br_dsize - windex) {
> +		uint32_t fraglen =3D br_dsize - windex;
> +
> +		/* Wrap-around detected */
> +		memcpy(br_data + windex, src, fraglen);
> +		memcpy(br_data, src + fraglen, cplen - fraglen);
> +	} else {
> +		memcpy(br_data + windex, src, cplen);
> +	}
> +
> +	return vmbus_br_idxinc(windex, cplen, br_dsize); }
> +
> +/*
> + * Write scattered channel packet to TX bufring.
> + *
> + * The offset of this channel packet is written as a 64bits value
> + * immediately after this channel packet.
> + *
> + * The write goes through three stages:
> + *  1. Reserve space in ring buffer for the new data.
> + *     Writer atomically moves priv_write_index.
> + *  2. Copy the new data into the ring.
> + *  3. Update the tail of the ring (visible to host) that indicates
> + *     next read location. Writer updates write_index
> + */
> +static int
> +vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iov=
len,
> +		 bool *need_sig)

Do you need "need_sig"? It's probably not for non-network/storage devices.

