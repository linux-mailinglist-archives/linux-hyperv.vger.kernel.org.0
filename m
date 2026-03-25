Return-Path: <linux-hyperv+bounces-9746-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJQfMMhhw2m1qQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9746-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 05:17:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041D31F951
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 05:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762D93069010
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2026 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777F2ED843;
	Wed, 25 Mar 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nkzheWyY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010008.outbound.protection.outlook.com [52.103.73.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0C2ED866;
	Wed, 25 Mar 2026 04:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411628; cv=fail; b=mBaezcbPSd8WBulZGYgzrWWvXsrpaqjE8KCm49LfbfiJUTFO5bU6V21m2AWFIDUxhywhmgnE6TRvVcHPQU6CpWiz48x3CchsQlO5nlf1qpAQSwL2oSPoFtoXS2ua1NqHlKAz63JpYV1DspWTOg5tpa+gL9POwSRivuF05SnotzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411628; c=relaxed/simple;
	bh=HFhz8eH72cknzZ9gBLWLxIWS+7HezrKDfGBWNoIpBPI=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=stbsZYN3SUWUhBM1UpheX/g4kyJXB/n5UNl9o52gUJ6fhvOJVR+ffy25fe7Mq1wA104fOMGjhIm2lXYKW++6Z9V3vuK1KdusEZ0dnbVExk4hL4HxNR1fexYkIYrLm35cdxGF3yNXQvb56M01Pk2GcoOcBBETNUkY+fBGlXjASvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nkzheWyY; arc=fail smtp.client-ip=52.103.73.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtEHYjJKWMMVsgBPHsCOP/Bc9CbrLj7aFMBT67Oy8V1DeRQS/0k/+d+ep90PWtdnFbQRP8TdEam+RVMiKpDCorI54Guo2i11CpMNqiFxZc64h22NnMtcJer3+U/2v8L4Txb1UUYZOsciKOxBYtLooOcUzPJbGsqzcRMiLKmxTsh6N7E4BJv8kX7+AB/wVbvXWren4Zawzp3tC6ziJPSi7nAIxQPd5DuMUORGSFKREMj4w2K1ZvxjQ1t9T+M8l7YfNladtKREGjUppfzgenP5RKCbhn3tSzgWAbCDUOEnxVzQ8xi0hMJ0UH2KkJCsGq63GjFuwD0tOck40gkiF0jsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzPZoemA5QbH1L+VbIrmeOWIM+zQzCTEtumroxaDsTc=;
 b=lnXpU4tLG6kEFdIXmaszz0Dv4jUStksAnCGH6sm01g4oCRdEHsMzr9QwvQscC52ZXQ9l6qxCW+LiJl4jxqzhTO7dqRnP87N/Dmcqm6d1eDz2K8z6yCokEVpBAGFdnY1bBD15xgNli4nrtAFX7V7y57q2qoHa5kncyBJe/EpQ2crbvpNe+vYxsgDdLmmH01AEa8hM3YRAkWUzgp3uct/byPG47KlJC5rY9NfeJGKhjgAqOricp/P0X0FyUAYEta/C0UCAC6jHCXRkGo7X9uUtwuL8bFAV0/sWZ83h9vtjK2vLDTkRg0MZKVJYPkmclUpuBPdEgvoBl3BJ8U3XnrHoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzPZoemA5QbH1L+VbIrmeOWIM+zQzCTEtumroxaDsTc=;
 b=nkzheWyYPbQV9mJRYLRbYTuLDyT694EFY66X3oswS/IQbujE60VJhhzM1Ivi0VJrqCaMSLtMBNPTFHcFdl+qcTCL8LucT9qO2yxg8HwIueZRvO42wDbN6zl6G7U8pHKg3F92m5DZX3Susg2XMlTYTiNIOcw+YZZDH5GBFHsTLGCXijb6bDbo29XitvmHCmM40L0PdjRDDs0qCCjm4HG8cXb6uUMRN7qFHoqQs8Yv6gU1pD0nKNd20VbSPXXd6DNJD1SlWwaT0Qwh7E4o9WXzmttslUOs4XLXjvPFY8q0timR/4fIqohBuYYi6PitrBgK1UGQP8NPnoMj6qViXe8wHA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY7PR01MB9778.ausprd01.prod.outlook.com (2603:10c6:10:305::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 04:06:55 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:06:55 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 25 Mar 2026 12:05:52 +0800
Subject: [PATCH] Drivers: hv: mshv: fix integer overflow in memory region
 overlap check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881689C0F58149DD986A6D1AF49A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNT3bTMitRiXctEUwsLS9PE1ERTUyWg2oKiVLAEUGl0bG0tALnIkkJ
 XAAAA
X-Change-ID: 20260325-fixes-9a58895aea55
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Mukesh Rathor <mrathor@linux.microsoft.com>, 
 Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Muminul Islam <muislam@microsoft.com>, 
 Praveen K Paladugu <prapal@linux.microsoft.com>, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=HFhz8eH72cknzZ9gBLWLxIWS+7HezrKDfGBWNoIpBPI=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhszD8fLCH1wWGD6+kLX+c+7SQ+ubXsTVubv5zJznLXxOY
 cLuOYu9O0pZGMS4GGTFFFmOF1z6ZuG7RXeLz5ZkmDmsTCBDGLg4BWAiYaaMDI/mPLogmH66R22p
 YkNf30mFDS8ELhsVCJYGsViKWK9bncPwV/Alx7JK1uCy+duUlkl/vZRfdrzLl2Hqnnv9OW1B4jb
 6HAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260325-fixes-v1-1-c6de9b4e1c3b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY7PR01MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b1710-af16-4ee2-05f3-08de8a23f349
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|5062599005|8060799015|41001999006|12121999013|15080799012|39105399006|461199028|23021999003|22091999003|24121999003|5072599009|41105399003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEQ0S2ZJaVZLNWpwRHRmeVJGTUdMTlZRODJ3d2M0NURyZEEvZnY4Vy9qSzFD?=
 =?utf-8?B?QnRwK0VseW54bFFKbXg1UVljVWJ3NE1Qc1lrSXhkUkxFTVJCUGtUYjRNSFlH?=
 =?utf-8?B?S2lDWU82cW1Rc0cwYVlsRi9BRXgyMzJOcVhoa0VMUGVFOUFaT0F2Y2w3dW8y?=
 =?utf-8?B?NmpYZSs2bjFtM2VWWU1OT0Q3YjVjdGNTZkRHLzgvb1I1VHhIL2ZNZXA5akUv?=
 =?utf-8?B?SXlmN1d4S2xBUkVpb0lsUTE5YWZZcVZkUmt5aFoyaHhRZFg2UzlZUzNIVlY2?=
 =?utf-8?B?Y1craXovZnhxUldKNDAwcmQ3RVNEejZISlg1cjVlbjhVdkM5Q1d4Z1RJanZx?=
 =?utf-8?B?d3hqMDFTdGVacjBaNXBNalZvQmFrL1NHRkx1TGsxL0Y5WjJHTmJZSzYzcm80?=
 =?utf-8?B?aXIwYXp2TTFlSzNXSE8zcHNnQ0tPVDFpcFRkNUVCejNoYitzVWdGNnFVczMy?=
 =?utf-8?B?TXlPOEx0TitBVEdVbW1ZY21tekR1WFNFQnF0dk9PQTB6bGJzbG9scEhsczNk?=
 =?utf-8?B?RlJqV0Z0RU40WUM2UTgwUEpPZ1IrK0hlS29xdEJ3ZWFlK2MydXVmbXZuSmhS?=
 =?utf-8?B?UktOM1dpTWg5WFFEcDJVSS8vQ3g5ZjhrWEZ0Z1U1TDhzQ0dsWnlHM1B4MlZZ?=
 =?utf-8?B?R1JST0ppd00vaDNYazBNZ1MvNkozcVFMMWVUQ0kzUEROelFyU0VQSUZOdVBQ?=
 =?utf-8?B?b05rWjBwTEljRGR5cU5idEptdVZXZHoyZjlhU1A0ck1Fcy80VE5SbFAyeDdu?=
 =?utf-8?B?Tkt5TjFKN0Fad0ZjaGtzSmZtbWpsVFkzWFdXN1BWUmFqTUtZUmNxTXIxS09j?=
 =?utf-8?B?OVdqSDlXRmxVS1djRmhlUkVONE1kaTAyZEh2T0E3RDEvVXcyeitHcjZHREhJ?=
 =?utf-8?B?Wjg2aFFPSE1hSUNqbkc5RFFSQ09sSUJVTXFCeXBYS2lXY1JEaURvc3ArMzZt?=
 =?utf-8?B?ZXI0SXpZaHVsNkxiTi93VVhwKzB3ckxpTW1JRHdKcUNaMjZDTXk0YlpBWWVa?=
 =?utf-8?B?bU5KcTFqeDdNWWI5OElpNDhmczAvejRmUVltNitIeEhpM1ZiU1JjWWhWM2xw?=
 =?utf-8?B?OE1STmphaHhlendwU0RlYWFHZGphL2cxenlzQTJZd29wR0NOczZCRmJvT3I3?=
 =?utf-8?B?RzJPUlZuNjgvZFkyZEQzU3U4QklEbXZ1TUMwVGlQMStpWjA5eXE3bjJiR1Ft?=
 =?utf-8?B?SFlvUXlWV3U3T2c5Z1pLN3h0YVB0dkpUM3BmRzR5NkFvNGMwMEswZjQ5ZFNX?=
 =?utf-8?B?RVNlSVluaFh4OHAxUEZ5Q01BWDZRTSt1VlRIaVRXL1dvZy9uNXpvTDhzKys1?=
 =?utf-8?B?eitJS0dGVGZmbWtFeHAyOEM0TVdpMzYrdHM0azlHdis3cm5WTi9JSjBtR0tG?=
 =?utf-8?B?QlFYMjJyczYvTEw5QlEwMHNXVG14SXE2ZjM0MUVOcVpSWDkrQ2JrakhxUFlw?=
 =?utf-8?B?Ui9EbHg3Vk0wSXhickNJU0NDd25Cb2g3ME9kd25YcGtRZ2RUUENlRjNsaEZ2?=
 =?utf-8?B?TERNdFVtTnBwWGgwQkp5TzdjOU83bzBGVUFlL010RGxzY2FMdnBwUDRuU1Ba?=
 =?utf-8?B?bFA3QT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnUyOWw5T1hxOFU3WFJQTEZwbkx2WVFMU3dvSFRRVXlYdmdtWFdhNFFZNTBW?=
 =?utf-8?B?THpka0hRWUg3aUFjTElxdGxqOXVic291NkFLQWtrVHJsVUpKbzdUSm1yLzhD?=
 =?utf-8?B?eFBXTERvS2RLem9tNGRvcHFqbjVKZlg0TUl5MFIzMG9nOTZMZzFyQUFUZHFk?=
 =?utf-8?B?Q1A0bjJ4RXZLdDhIdjNZdTRHT00yMktXMmxUYjZUTFNrVE8xdEV5SDFmMDdX?=
 =?utf-8?B?Y3JpcVpWOEJXb2JmNjZaQ2YzME03bUdQZjRuUmRGK1FPZGZUd0UzeW9zRm9H?=
 =?utf-8?B?cGtiMFYvRWpFTlJmdjlMWTgxN0l3MDFTLzE3UWE2MWpxZE91aG1zUGlDTlBJ?=
 =?utf-8?B?STE2d2ZaY01YWEdla2RiNGlhdEoxYUsxVkg5L3hmc3BBazN3Y1ByRFVTOEZY?=
 =?utf-8?B?MDVVQmdkVlMxai82VW4vUFFtSXhMT3hyZmFkQm9pYzFoWUQwWHE1eHhhMUFn?=
 =?utf-8?B?b242MGtnU1JJejJqUHc2aUFjM1hDdFZoQ2VScHZJTW1nM1I2S201dWdOUkRZ?=
 =?utf-8?B?ZThrRzVhY0ZQK3prK29wSXgzY1JJM0R0bTBwckdaVmcvajVxdWVQWkRhSjJE?=
 =?utf-8?B?eS90WEFVYnRrRU5YWlRjaUNlVnNKVFF2TXhIVUw2K0haTzgwYkdvR3ZubXNu?=
 =?utf-8?B?S0ZMTWVxUjRVcHNqcHA2R2g1K2x4QXdzWGRNOGtWTFk1L243RFVkUlllaExF?=
 =?utf-8?B?SXBGZklTWTZNZ1ZST0tXWlZRcDVPRElleWZMbllUMEN5cC9WUVZWYTdKTFB0?=
 =?utf-8?B?Z2lTR01DbnBaNytaNU9SU3hPOWtWY1c1Zko1Z2xaZnlaU3htTDdqMTRLQVN3?=
 =?utf-8?B?VUt3NkRCckY5THZYaTduZEYya0s2NzVPNlFDZDI1TXhDdEVEaktkcG5BSjB3?=
 =?utf-8?B?WC9hUHlLbFNxT21FdzhWbkF3Mzc4TXgvY0xnQ2s1WlNTejU2OWZrQ1FZU0xn?=
 =?utf-8?B?VUxCSk40ZWFjTkpNTmZmNk45WTZmdDU3MjZqazRLSDYwcEFRaFlVN05sMlgy?=
 =?utf-8?B?bWI2SVRWWmdBamt4K092Vm5wMWdacDFlRW9yY2o1Ni9zK2R3c1VHeGZneWFh?=
 =?utf-8?B?MmE3TVlKc0doS2Vkd1ZCUmtTRGgrVHQzVC9SU3lzeG53UGgzUHNYTENwdWRn?=
 =?utf-8?B?amhDYnV2UnNXMnRYYmd0bXpVVjVKcjd1RVM3WHJ1VnNPTXJndmgrR2FLYmRx?=
 =?utf-8?B?cUMzTUM3R3hZYlNMTlA2K3YwMGgxOThyVk84ZGphTTZrcEtmbU90M3dlNVVC?=
 =?utf-8?B?cXhzeElNVEVQUzMzdGl1QzI3ZDF0a3B1ZDhoQ3p3cjdCdXU5WlN6RHRYaGRv?=
 =?utf-8?B?MlBZa080aVU5Vk5kWjJTTnYxbXdPYWxjNXVGaDBlU3BBMkpLM2lzUlhBTTRo?=
 =?utf-8?B?dWV6cUk4Nk4rSFNDWXM0dVJteUVSTW9STUVUdVE1eUt3VzU0SThVR2xrUVZ0?=
 =?utf-8?B?dzF1V1dVM3k3aENTRkxmZmJWdHB5RmorTURwdHdxMkZjTzJ1QkhYb0pJMUds?=
 =?utf-8?B?KzA3TWdhbVZKWVJtajBGUUhSSGUwWGw0VnlPWkF5WVFpL3k5TWU5bGkrTk1Z?=
 =?utf-8?B?eTYyM0ZFVHRZUHF5Ympac09Jdms4M0p3WnV1S01Kai9oTi9tZklYRnFkekFl?=
 =?utf-8?B?RTBLNVorTnVCTklKaFdRei9iSTdBTGUxd2hCcVoxWStnbUdCcEtEaFlhMnF4?=
 =?utf-8?B?MUp5MTVNc1BSWDF3eXdXU3Mxck9BekE1aktNeC9KR2l1ZGtmbzM2enNLOFhz?=
 =?utf-8?B?Q3BmOTZtUHdhOElXeUliTml3MTRBVXpTaHBjL3lybjFlbGsvT202bW1tODc0?=
 =?utf-8?B?QTExaWxuV3RLeGRNV2RyTC81T0xHNXczSTB2dGN1VWlQUnRoaU1xNE9yMzVw?=
 =?utf-8?B?WGhSNldzcC9Ra1RQa1NvZUlNTVUvR3RrSFNubHh2RkI5UVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b1710-af16-4ee2-05f3-08de8a23f349
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:06:55.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7PR01MB9778
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9746-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 3041D31F951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mshv_partition_create_region() computes mem->guest_pfn + nr_pages to
check for overlapping regions without verifying u64 wraparound. A
sufficiently large guest_pfn can cause the addition to overflow,
bypassing the overlap check and allowing creation of regions that wrap
around the address space.

Fix by using check_add_overflow() to reject such regions.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hv/mshv_root_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6f42423f7faa..6ddb315fc2c2 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1174,11 +1174,16 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 {
 	struct mshv_mem_region *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
+	u64 new_region_end;
+
+	/* Reject regions whose end address would wrap around */
+	if (check_add_overflow(mem->guest_pfn, nr_pages, &new_region_end))
+		return -EOVERFLOW;
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		if (new_region_end <= rg->start_gfn ||
 		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
 		spin_unlock(&partition->pt_mem_regions_lock);

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260325-fixes-9a58895aea55

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


