Return-Path: <linux-hyperv+bounces-8628-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFP8GpdDgGnW5QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8628-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 07:26:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0AFC8A56
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 07:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4A1D301DAC9
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 06:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C12F619A;
	Mon,  2 Feb 2026 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Me4h7CgT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012016.outbound.protection.outlook.com [52.103.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F72F83AC;
	Mon,  2 Feb 2026 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013550; cv=fail; b=kMSJOVpWtKBpyAl9w9QZQReYjOcGUBXg7LSluI4aBNhoEoRnWW7DK3bSIcixKQ3nzGO+rk1r27pX10fiMhXSKpj2v09+dPcOQlfdmWLlSMgN58jnT8L1q57Lj/gAiRoHN6ruJQt6UffPXk68JlEf0gwUGry/JmXbsQseTJk0qkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013550; c=relaxed/simple;
	bh=ptHAc1SuXbGfm4K0OCynEWkUyv4M5cevsfiJQ/5v81Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pr2A/T8hEjKwRcZ57tbKnwStT0SSEToB5O//TxftTJ1M3a+Acgw0uvIGs2tudNmwN1E1pjKLrN7xVMa9J7N5zCYbcn0yWbqBxNCYRQnyDA+NTYAKHoTT9ebupAfvBLs+uTxGZh7UpRQBpH+Lqe2Rwkd0xH1MJEbSZp5oA2A3z4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Me4h7CgT; arc=fail smtp.client-ip=52.103.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfYQ/M8iskR89QfzmgyRSYhDOZg2gDlbodI0CEXZ26ghMAPMkL+QrRhP3XS683ta7coKn99cPFfPONrlAvW19aP1EVKDa7vEm+3cS7OL7+HAkupM/4tVjI9XNZ88xBe5Q6tkRVIwtXiLK6qI6YnCEm73Cb7LdAgxdiqeFbGXMSjZXZJh0wzPSVNH2Z+V++lBfEcGj9aDMdLdeoEZAAj8Ocue9ZwnLGtgH7CYdizBkSuEz+rAEsyZgPjCJN1A5cMZE7AJqgRkUMW3aEgoaHs1oUdME4u760PWkS8Nj4227cFI+vjskDhntnyo5wuBd6FBxTLHkrrsCYdo7lx4j5bWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp7ptSJfsOllwHYiMBqTlK8WeIXeZ8cIlkC5sLufDDw=;
 b=W+c8tFKuTbYTogguNTsxE8PWU8sex9THDS7sKSNf2wPqrtt4Z0DiFU9DE3LfmUwgRl3tZZQ7avggXplkn7sUznOZA/ce3IfXqiV6UfZhdkw6FPQPE7EEqfg2GKj6pc6bZmP7IipjY3KWzigihzkLsSLEqpzBcZryaT1BKsAtH35cahFAsO9qtTuGvytn6+RMQaNxkwln+eHsHO196oRKP7f4im/1MnIoL3+1RYWNtlcmGWM7SGQ+IHNHDV+5q9vRc0ojPngisTBBCOSxIXeBmOEq+PiNqkBs5VdvffgnYlkisRkZMHSD5vo06EmaHZCxtc6IVId0wqXM+Uir7oFV7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp7ptSJfsOllwHYiMBqTlK8WeIXeZ8cIlkC5sLufDDw=;
 b=Me4h7CgT/pciv2C8IAVDI+MlJfxABSbb7TMFBbVxXD1kb25dfCMZWMrKRoDB3ZVc7bS1Eqp06uA1WNdsUumQXrjijpkIX0miYHfwOzloaxAGCK7gAxl4kRPGMucK/Jyr/dh9P3hCVNa3HMTau5QR5v6DycbIRgaZJgC26NAHi0B7T1W7ed5NXOF714BAjl+k4BmHGC0RaZcwOrDBINMCG43ez3pWjz8KY+c+GtgGuidFXWgiBtk3MlB7+9crxnm3WXu7oEYWftXTvhvVeFlNLyEMYY/v0nz5a5nDOwExG0nk6+luG+aIJ5fTBYONjX9thOmWJANTW5FFEiQ+oXIKJw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7693.namprd02.prod.outlook.com (2603:10b6:a03:318::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:25:45 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:25:45 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Topic: [PATCH 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Thread-Index: AQHckHCLE8jASLTQ4keASoBw6TwktbVu8q+Q
Date: Mon, 2 Feb 2026 06:25:44 +0000
Message-ID:
 <SN6PR02MB4157C364D3F700A37C41AAFAD49AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
 <20260128160437.3342167-3-anirudh@anirudhrb.com>
In-Reply-To: <20260128160437.3342167-3-anirudh@anirudhrb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7693:EE_
x-ms-office365-filtering-correlation-id: e4999c79-74eb-4560-4793-08de6223e542
x-ms-exchange-slblob-mailprops:
 5fu/r660v9OFyJ+CxyO6ueseEO2yHaMVbWSranQR6YJr864AlgR+Q18rAuc6kpcBxgX3YmyNKzq3oZWmIaYOoXdmWBkNO8YC5Jsl9ZF0aFdyAZqiMS6JYoXJqQsnBA2Icdp/JCorW8fyWnnp8ApFUxkQKEK22HwWuMjuxB5PxsfPzVWl3ialvHgXtLQ/7LfESRbW9LsVDLsq+v4DWEIHtzyM/B46z8LIwhbhLUIfxx3OPA1JEceVBj89DH94Jkq46KCbiKzLxRxIJrbZwTxDDlXK2BE9OgNhnTiWPLDXjtAVUgB11iH3xNxkf/76WCfwGkfYT03+BXucLzecqTvfTD5n91A4VyRXH+10KolSNPcit1n81i9xYhFrodHy/I8EC8G4Ntm94x8POaSeuqMnMG2ow0YrhVvIoC4DgsM424lTTPQQ8k9vtar7hpfLE8f2Urv0jP4FtkAO3kBLgLMFH6bVui3VH8EMxHdi9M17S251PKcoFAHc9EA05Y5aTI1bN/CVkBwHhTR/LZk7eS8rGTcqooMONwkXJY08cHfUIOU0cpwnyVQ/C3Q2NpiLJagpVflrXoANmbvcNw7jfUqcLEFBvW3H8OV+TKjZawczZr+SxJ3IMRuM90eLIii2I097dgSi+AJpr1M2MLVoLN0CzTM6rWxSRcyYlbC6uvRLrPlN14dI9iDP5yRfLy1F2gFDI8/lBjEpUaXvT2pYHQP7z2BuuKkNFCULjhvOx2Nodtk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|461199028|19110799012|31061999003|51005399006|15080799012|8060799015|41001999006|8062599012|40105399003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UBdUyAGjH6JhQG4ajFEyAriw2UoyVmXMALD5dxuVBKxzhnuZcwQ92oCLWhxB?=
 =?us-ascii?Q?1yVvqSskDd3TzZS3fYFuQKH41YPojVelaGqxQWii+4wn99pCWk/JInVUUYsT?=
 =?us-ascii?Q?qP22/Fj2LdQ++UtOXRac/DyZ4etEhZdY1PuoNMsXMJqlXbCTtzvRIKRYZu2O?=
 =?us-ascii?Q?u9BLxOPGjORIbKowNVoExMAjPpwofA67RCrYltDR2EgOt+lZsZ5U4mvrmeQQ?=
 =?us-ascii?Q?ENLxmsv8bsgQzEBsgUq9cJoLa/TWB+osTcB2e9TQlVMQCs5DGX3GwVcPPeZa?=
 =?us-ascii?Q?Ta45a6YaGfngK4olG0SM38yTTJcXBH0S9lqdV6ByXUnN+fJlDEMzVkkS0VkG?=
 =?us-ascii?Q?G0kahdQ46U7ZBD72vJiyp+lB/wNWdWub4Uxje8R/clNNt8k52v58BzVQ8IGX?=
 =?us-ascii?Q?339ZKTrs/E7reuZQXsyL8HsHsbZbtdV41L1SUUvs3OMj1Mnrj6jFumDVZJFs?=
 =?us-ascii?Q?uxErRcDcxVyBbCAwFzKwVYQlQovWI0ooHQcRnKlriBHSoV366+KZxz45yiaf?=
 =?us-ascii?Q?r7kwmzBxAea4SIncKuRPbqSAZ1Kc+gsr6z290vUoAvq5P4qJd4DtIvPTeZON?=
 =?us-ascii?Q?B6+E/8K/S26UfmIatL1++hwFYsqrRmoYKk9hb6Ji28w5iD1MGCZbs4fqEI0Q?=
 =?us-ascii?Q?EYjbEJ0rXHPlj2tthaD21K4LrhkDcm7cCbavYkLwQZJE4BUI9P99/Hmac+DA?=
 =?us-ascii?Q?vvirPxQW5AEn2ZmEqDiNXE1b3O3qDSDX72CcLwZs02XxZarjyxvunxH0jzzC?=
 =?us-ascii?Q?cpUxDgpHQJJB25zXa6EIH60Ns8JH5DHYi6WN5vif7M42SHky90WobKV9MN3c?=
 =?us-ascii?Q?fDMazefXIf3/A3tCn3xdQwk6VxMBLV5JOPV+oRvJLCkEBCYVBm86J1eqndX0?=
 =?us-ascii?Q?PXHjwEl2b7RL9zmb65Qv+onAe58licVj/ZLyfTD93OoSe/HyqWJi7L4iBorU?=
 =?us-ascii?Q?FgJ9QNwod5lU5iaZ7o37g/IUvKi0HyTC2OPRaY6SCLlBZNWSRcjMrp5BnGjk?=
 =?us-ascii?Q?0McSLBLjAyMb/yQsPz3uez+cv3qG51babTe1ua8bGYuVfXeDGX/RgO94c40t?=
 =?us-ascii?Q?OZftpmuhjxDP0YKEYRBS4X4i8I0LI43TQFoT/9JotP/Nhx2hTuNyDVfimt5c?=
 =?us-ascii?Q?9GtP3LIVPmhIsLoJ7AWa0HfKAIB123M7QgGnrtzaPJv12qzjF/DAYmVg1dgi?=
 =?us-ascii?Q?t6KMhgtEjnghgqm9TdTRUbu3dB2Kat+5/abuEtwxqTjuem9yPGEaFvlqhdY3?=
 =?us-ascii?Q?oU/AYvWd8WW5dpVGjRKWLrRUyGl4cNbddZgUJEmOrQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1tZjzfHq0PYoP20DnLYNoWi/95WQZUoT0v15aVcDuMG8Ws79Hb0vGY4ucLis?=
 =?us-ascii?Q?8AuxHm9Qloop6vDQneAQkewEj9nMvvv4xz4u0VlUHKbpfdsExZUJjcz8fkTz?=
 =?us-ascii?Q?dv0ou/nWbIMgf3eLhcg/IeZkVH5jqEnb17KSJudm/P27b+Cprxij/k9VnNEt?=
 =?us-ascii?Q?xttf7apFcl+dUN6bQg1Zsnq36HETOgCTdQB8joq1xrowPHZw1tpndQ3OuV6F?=
 =?us-ascii?Q?9NP0twpQ2EJbTOjfS76i2myzMNaKaTJZQwjugydBPcE5IfHG3Sd7ZNxKMR9f?=
 =?us-ascii?Q?avVOijy2iwYSpvYrvr5EG8ljsHMMWVtNMOdXrMsTj1Rwonmj+DiQsqNNvkQt?=
 =?us-ascii?Q?0M2YDxIuVgpI5yfLIVUE2XcPGFffi5fhCOYHZw7iFbl04UnId9zOl2WeyiUP?=
 =?us-ascii?Q?JT3UhbT52ACieRQXu59wZ/Y2qo3NJ43emip2tb3Pks2T2Ee2E+CbyqripC7j?=
 =?us-ascii?Q?BvY42k+90IkKqepP9hbiPE4bUZKw6K1qzCacm3CfR9kexKG33DYZz7/JdF3g?=
 =?us-ascii?Q?m174Vx1rYuNGJG7sBaGwieyJWLNIcEoyLZGR0ZEPJ/ZoqykGUK8J9aGeQIRD?=
 =?us-ascii?Q?Q/kQlBLWrdAeziZEqbuEW5RQPyaq8sFZs91hnyZzCd5NajPxRgeETN/7CLjJ?=
 =?us-ascii?Q?/KOA7udfSTKyBpF8OQ+bxrixbXQvIzCMsbslUY0SvXWcwbgk9IAwJoJveyAa?=
 =?us-ascii?Q?KLWAs1LFjwvj5TQUkCuLKS1DZ33AXf2T5kBwIvzztlt18poc+XgodHmS8xOf?=
 =?us-ascii?Q?YdLmWDz9dygT6XFhTw2O0Yehz8hnKBRUoQqB/Hb0whQV7xIhZJ4E2+K90k01?=
 =?us-ascii?Q?oMTQLQknx3SrHUGhnPljR/i3tyoF5Na3viOCTeiq30MfF1b3MlXCJSsl4P70?=
 =?us-ascii?Q?CeXqih5t57YH77oWTlzGSrYlxu2H7XD6p9OSNFJsJfRYaODNMaCdtb8S/F+Q?=
 =?us-ascii?Q?FQ2xsAXt4FRY+/wsGi8vX8J3RHUSX4dY2r3SePN28v9yaeXJanXbgcN+lLoA?=
 =?us-ascii?Q?5S7YB7y0pGqBhTNPYJq9BMtUDGBPNSclbgvFQy7N9ubf4MfoPcvArc6JZurm?=
 =?us-ascii?Q?Z/2EcMijAGLOMAjJwxPVi/yIDogS0I4scJd8xASbAwqRiO1/yo0Qlc0bZcmn?=
 =?us-ascii?Q?+804v/IwOut7fNen8p8l2zGYVq95Dv+EOuNeYsDWuUchl9iWbV1NQpmXR8Bi?=
 =?us-ascii?Q?D4JJB4pd5YWakzhDeYsnS70u2XDyvFyWT8N7udgrFLTu4Zb7mYrnHE1zOirS?=
 =?us-ascii?Q?D9+Yd98c1UBLfJLkH6+EZBFIQJTpHTBceBiXB8O54cJGAyIjgkdx3cCMTXaA?=
 =?us-ascii?Q?ySZ6kQ75wZBILvJT8EefiYwYAmP/frDA8aQYdtKGgKHZ6buTtYYL3Uz4kRp+?=
 =?us-ascii?Q?5n7NBPg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4999c79-74eb-4560-4793-08de6223e542
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:25:44.2691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7693
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8628-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: CB0AFC8A56
X-Rspamd-Action: no action

From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, January 2=
8, 2026 8:05 AM
>=20
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
>=20
> On arm64, the INTID for SINTs should be in the SGI or PPI range. The
> hypervisor exposes a virtual device in the ACPI that reserves a
> PPI for this use. Introduce a platform_driver that binds to this ACPI
> device and obtains the interrupt vector that can be used for SINTs.
>=20
> To better unify x86 and arm64 paths, introduce mshv_sint_irq_init() that
> either registers the platform_driver and obtains the INTID (arm64) or
> just uses HYPERVISOR_CALLBACK_VECTOR as the interrupt vector (x86).
>=20
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

I have a few comments below for starters. I'll do a more thorough review
when your v2 comes out. FWIW, I'm in full agreement with your take on why
the code is conditioned on HYPERVISOR_CALLBACK_VECTOR and not X86_64
vs. ARM64. Of course, I'm the one who wrote it that way in the VMBus driver
back when Microsoft first supported arm64 guests, so I'm not an independent
observer. :-)  But if need be, I can expound on the thinking at the time fo=
r this
case and other similar ones.

> ---
>  drivers/hv/mshv_root.h      |   2 +
>  drivers/hv/mshv_root_main.c |  11 ++-
>  drivers/hv/mshv_synic.c     | 152 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 158 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index c02513f75429..c2d1e8d7452c 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -332,5 +332,7 @@ int mshv_region_get(struct mshv_mem_region *region);
>  bool mshv_region_handle_gfn_fault(struct mshv_mem_region *region, u64 gf=
n);
>  void mshv_region_movable_fini(struct mshv_mem_region *region);
>  bool mshv_region_movable_init(struct mshv_mem_region *region);
> +int mshv_synic_init(void);
> +void mshv_synic_cleanup(void);
>=20
>  #endif /* _MSHV_ROOT_H_ */
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index abb34b37d552..6c2d4a80dbe3 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2276,11 +2276,17 @@ static int __init mshv_parent_partition_init(void=
)
>  			MSHV_HV_MAX_VERSION);
>  	}
>=20
> +	ret =3D mshv_synic_init();
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize synic: %i\n", ret);
> +		goto device_deregister;
> +	}
> +
>  	mshv_root.synic_pages =3D alloc_percpu(struct hv_synic_pages);
>  	if (!mshv_root.synic_pages) {
>  		dev_err(dev, "Failed to allocate percpu synic page\n");
>  		ret =3D -ENOMEM;
> -		goto device_deregister;
> +		goto synic_cleanup;
>  	}
>=20
>  	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> @@ -2322,6 +2328,8 @@ static int __init mshv_parent_partition_init(void)
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  free_synic_pages:
>  	free_percpu(mshv_root.synic_pages);
> +synic_cleanup:
> +	mshv_synic_cleanup();
>  device_deregister:
>  	misc_deregister(&mshv_dev);
>  	return ret;
> @@ -2337,6 +2345,7 @@ static void __exit mshv_parent_partition_exit(void)
>  		mshv_root_partition_exit();
>  	cpuhp_remove_state(mshv_cpuhp_online);
>  	free_percpu(mshv_root.synic_pages);
> +	mshv_synic_cleanup();
>  }
>=20
>  module_init(mshv_parent_partition_init);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index ba89655b0910..b7860a75b97e 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -10,13 +10,19 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
>  #include <asm/mshyperv.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>=20
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>=20
> +static int mshv_interrupt =3D -1;
> +static int mshv_irq =3D -1;
> +
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
>  	struct hv_synic_event_ring_page **event_ring_page;
> @@ -446,14 +452,144 @@ void mshv_isr(void)
>  	}
>  }
>=20
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +#ifdef CONFIG_ACPI
> +static long __percpu *mshv_evt;
> +
> +static acpi_status mshv_walk_resources(struct acpi_resource *res, void *=
ctx)
> +{
> +	struct resource r;
> +
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		if (!acpi_dev_resource_interrupt(res, 0, &r)) {
> +			pr_err("Unable to parse MSHV ACPI interrupt\n");
> +			return AE_ERROR;
> +		}
> +		/* ARM64 INTID */
> +		mshv_interrupt =3D res->data.extended_irq.interrupts[0];
> +		/* Linux IRQ number */
> +		mshv_irq =3D r.start;
> +		pr_info("MSHV SINT INTID %d, IRQ %d\n",
> +			mshv_interrupt, mshv_irq);

Is this pr_info() necessary? Once Linux is running, the output of /proc/int=
errupts
shows both the IRQ and the INTID.

> +		return AE_OK;
> +	default:
> +		/* Unused resource type */
> +		return AE_OK;
> +	}
> +
> +	return AE_OK;

Having three occurrences of "return AE_OK" for a function as simple as this=
 makes
me want to look for simplifications. :-) The structure matches vmbus_walk_r=
esources(),
which does more. Maybe there's value in preserving the matching structure, =
but it
might be equally good to just do "if (res->type =3D=3D ACPI_REOURCES_TYPE_E=
XTENDED_ID) {"
followed by the real work, and then have a single "return AE_OK".  That dro=
ps 5 lines of
fairly useless code and comments.

> +}
> +
> +static irqreturn_t mshv_percpu_isr(int irq, void *dev_id)
> +{
> +	mshv_isr();
> +	add_interrupt_randomness(irq);

The add_interrupt_randomness() should not be necessary. The Linux IRQ
infrastructure that invokes per-cpu interrupt handlers should already be do=
ing it.
When using HYPERVISOR_CALLBACK_VECTOR the Linux IRQ infrastructure is
bypassed, so we must do it explicitly, but not in this case (unless I'm mis=
sing
something).

> +	return IRQ_HANDLED;
> +}
> +
> +static int mshv_sint_probe(struct platform_device *pdev)
> +{
> +	acpi_status result;
> +	int ret =3D 0;

Initializing to zero isn't necessary.  All exit paths explicitly set the va=
lue.

> +	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> +
> +	result =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +					mshv_walk_resources, NULL);
> +

Usually don't put a blank line between a function call and testing its resu=
lt.

> +	if (ACPI_FAILURE(result)) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	mshv_evt =3D alloc_percpu(long);
> +	if (!mshv_evt) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret =3D request_percpu_irq(mshv_irq, mshv_percpu_isr, "MSHV", mshv_evt)=
;
> +out:
> +	return ret;
> +}
> +
> +static void mshv_sint_remove(struct platform_device *pdev)
> +{
> +	free_percpu_irq(mshv_irq, mshv_evt);
> +	free_percpu(mshv_evt);
> +}
> +#else
> +static int mshv_sint_probe(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +
> +static void mshv_sint_remove(struct platform_device *pdev)
> +{
> +	return;
> +}
> +#endif
> +
> +
> +static const __maybe_unused struct acpi_device_id mshv_sint_device_ids[]=
 =3D {
> +	{"MSFT1003", 0},
> +	{"", 0},
> +};
> +
> +static struct platform_driver mshv_sint_drv =3D {
> +	.probe =3D mshv_sint_probe,
> +	.remove =3D mshv_sint_remove,
> +	.driver =3D {
> +		.name =3D "mshv_sint",
> +		.acpi_match_table =3D ACPI_PTR(mshv_sint_device_ids),
> +		.probe_type =3D PROBE_FORCE_SYNCHRONOUS,
> +	},
> +};
> +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> +
> +int mshv_synic_init(void)
> +{
> +#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	mshv_interrupt =3D HYPERVISOR_CALLBACK_VECTOR;
> +	mshv_irq =3D -1;
> +	return 0;
> +#else
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	ret =3D platform_driver_register(&mshv_sint_drv);
> +	if (ret)
> +		return ret;
> +
> +	if (mshv_interrupt =3D=3D -1 || mshv_irq =3D=3D -1) {
> +		ret =3D -ENODEV;
> +		goto out_unregister;
> +	}
> +
> +	return 0;
> +
> +out_unregister:
> +	platform_driver_unregister(&mshv_sint_drv);
> +	return ret;
> +#endif
> +}
> +
> +void mshv_synic_cleanup(void)
> +{
> +#ifndef HYPERVISOR_CALLBACK_VECTOR
> +	if (!acpi_disabled)
> +		platform_driver_unregister(&mshv_sint_drv);
> +#endif
> +}
> +
>  int mshv_synic_cpu_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
>  	union hv_synic_sint sint;
> -#endif
>  	union hv_synic_scontrol sctrl;
>  	struct hv_synic_pages *spages =3D this_cpu_ptr(mshv_root.synic_pages);
>  	struct hv_message_page **msg_page =3D &spages->hyp_synic_message_page;
> @@ -496,10 +632,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
>=20
> -#ifdef HYPERVISOR_CALLBACK_VECTOR
> +	if (mshv_irq !=3D -1)
> +		enable_percpu_irq(mshv_irq, 0);
> +
>  	/* Enable intercepts */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_interrupt;
>  	sint.masked =3D false;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
> @@ -507,13 +645,12 @@ int mshv_synic_cpu_init(unsigned int cpu)
>=20
>  	/* Doorbell SINT */
>  	sint.as_uint64 =3D 0;
> -	sint.vector =3D HYPERVISOR_CALLBACK_VECTOR;
> +	sint.vector =3D mshv_interrupt;
>  	sint.masked =3D false;
>  	sint.as_intercept =3D 1;
>  	sint.auto_eoi =3D hv_recommend_using_aeoi();
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
> -#endif
>=20
>  	/* Enable global synic bit */
>  	sctrl.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SCONTROL);
> @@ -568,6 +705,9 @@ int mshv_synic_cpu_exit(unsigned int cpu)
>  	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
>  			      sint.as_uint64);
>=20
> +	if (mshv_irq !=3D -1)
> +		disable_percpu_irq(mshv_irq);
> +
>  	/* Disable Synic's event ring page */
>  	sirbp.as_uint64 =3D hv_get_non_nested_msr(HV_MSR_SIRBP);
>  	sirbp.sirbp_enabled =3D false;
> --
> 2.34.1
>=20


