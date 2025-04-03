Return-Path: <linux-hyperv+bounces-4792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC9A7B0C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7167A6B70
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9B1C6FE4;
	Thu,  3 Apr 2025 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fGOkUUv3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD62E62D3;
	Thu,  3 Apr 2025 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715367; cv=fail; b=C6No7LdP7D1InUcq5pYlLGNpSAYpIjE9l94aaXtgIw6VO87w07WxY7ko6+jEfroWy0sswrA3fWww2enkxb6wSyleso1t5ZXHWh7rsGIJVWlSIT82o0N2nt412u9QSSEfjdj1Awr74rV+N7O3kOuwg2jv4Vrc0AYHaTuwpF7mR0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715367; c=relaxed/simple;
	bh=BhkTX+3cRZpvD99hP2rtJlEjl8liXo1lWZfrxJxX7Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p9x9HoCs5E7sM7YydRe8keY1Z9nYB4uqGyES/vShX2eKKphX+w8VvRaMI1Jhzkk8kWmlfgHQXRuJbqtDIz1ZZJSwa30P2UK4MbpAvzwPyt57ncclaLG9ihpltP7Y0MzMjyXyYPevI2cN/F+UcdJjR4MyHuEX1sTUjK1wDNrdGEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fGOkUUv3; arc=fail smtp.client-ip=52.101.61.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX07/7i81dgi3K4jtszF/GBsBiGLwjdYY33m10P+822eyjn7CDdeViCKLTbpmY1o/fr1WTt4yfuhtJYWrj5mPp9wO48ViuP/unSqIDXMDOswO7IAmeTbuJ2RrcgIY/C9/8haqvXWBdmHDNvE/qBSwzyc5LDvkUMZFPd8laLeLiISSmvtMfj3Kbf8g/jL7T+SIM6OM0hSA2GbLXJh+3x4TfAu1oUiYnRau45R90aNLTboKPQiglaz+SGLRplGLhGQWfEtdNBo3cH/7f4DdlxqOZSDN9Ecpsb7sMBBfW4ehBVnTzn4Ih/2RBlek44VueX7FdgsoYmckl4rVupLlyOBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmkYm4l46pUzG6luT2oJ0BZq3IhiZzkdvKYv/hjx7nI=;
 b=tDMzogqFgvnqiYA9+/b3hjL3+04I+FaYIHCK684/3S0DAKDyUZ0+TCeOD2/wsfJ6mfHia49TM7GTvy/19bqUc0E9/dNz5DplB9JD/XZOGigNC2cc/5m6oOvjErdsSGDmvcl184KoVfG6pfiixiQh+WbelTuV9F6jbY4AaBm4IT9mW9mWIvT52+jmf4x/9LFKDfJQrgywTXPfjYQDpoOl0uzrP1OQxIWs/CWAjSoDHt+TQm0GdChjFiKzSgvrX/CM5mmO4N82ihPhlAPxQ9Od89yNtlDjYv3bgyxRFoChZCFs6KGQ8ywoPMOY0xluQrEX1UVf+nO1CRe9crmUJGLUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmkYm4l46pUzG6luT2oJ0BZq3IhiZzkdvKYv/hjx7nI=;
 b=fGOkUUv38zcnJisTPm3gFKxuoz5IoQ2MHFUyYZ8LGY6BoP2D38pnuukBCCgnQKnsk1bgfB3iT13TwRdkn8ZjADPHSFPe4UQYz53wb73l1Ci2+zVZArKXhXFF2/VnNWI63/vjzFZH/0+UhEar8bqYLDdIgcWyDzuXGyLLa2XP2ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16)
 by DM4PR21MB3154.namprd21.prod.outlook.com (2603:10b6:8:66::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.9; Thu, 3 Apr 2025 21:22:43 +0000
Received: from DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992]) by DM6PR21MB1451.namprd21.prod.outlook.com
 ([fe80::7a3a:a395:66:b992%4]) with mapi id 15.20.8606.022; Thu, 3 Apr 2025
 21:22:42 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	longli@microsoft.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: Explicitly check & doc fragsz limit
Date: Thu,  3 Apr 2025 14:21:47 -0700
Message-Id: <1743715309-318-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To DM6PR21MB1451.namprd21.prod.outlook.com
 (2603:10b6:5:25c::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1451:EE_|DM4PR21MB3154:EE_
X-MS-Office365-Filtering-Correlation-Id: 49751c17-34a7-41e5-af64-08dd72f5ab54
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?b4CMOhtPJXnxbVQZ2HsViD2tyWj8+0cdCr0imIRdSYq9lX3onfYjQkn9239X?=
 =?us-ascii?Q?PpREkmDdI/wwVjnvZBgc360946eLLhnagnN8rE/iCa00ZjWlZ7H9hiQ8dQkc?=
 =?us-ascii?Q?1R2vMggqABzaYazyH3USpz0hcIgBbioS0K6wa5sDRB5+FuocJEYqg57Yj5Nl?=
 =?us-ascii?Q?ujMNurfgl7LYs6WH54kWepnujDxeNzCN48WatR9IScVZ9/gVZWpVBHMwp0/K?=
 =?us-ascii?Q?G1/OuCu6ev/BlUf0laAsux7LHMAIJYw24TTBJGZj7pNApB32idQA+oLHGth1?=
 =?us-ascii?Q?5VAu3qLEvTWwLM62qJ5pZP7Ol5m/EA07IXXfFUbTZ5y0Y1GuGXwfacId2tHv?=
 =?us-ascii?Q?NuESsAw0+7B1Fnj/lVcatWhurSD76gi+x6mU4lD/AMzrFjiwOkrksFAyg/fX?=
 =?us-ascii?Q?8mYUe6oYMbPKdDlxf4FmpZ2JowP5G7o+P4R8U7xMw1KaIFxGwZ+jxvxeaEfQ?=
 =?us-ascii?Q?sct0e/PVI+VoIRJ3oxKOL1zuKI6cTJzdIebd4zJ9YjX+SMOzCXBx4FGundiN?=
 =?us-ascii?Q?tA/KlnK82LYCo+fWjI3HFRbqf/cfbriKM9Zr+x2eDTWvMMmviIXPuxOT/xec?=
 =?us-ascii?Q?VvrAy4e6ORsO84gXuxHQswelIilVJgnBTxyXUTy0bIi6Kuh5znTpbs99xhMv?=
 =?us-ascii?Q?g++9yq43v87Pm3UBIMgZmFQxj9N9N+BohLOQu5sMXUtNZyPNrlrsNJa93WZ6?=
 =?us-ascii?Q?dWl2me2GWWvw5nNuZx6dRCYBg6KPNsf4EZ97ydwm5TQBd1xCZY1eugtVqRTh?=
 =?us-ascii?Q?C6w9MUowwKXGfVnMj2nmif4p/61HTzOJm9luGZfd2D1QDbzUwdYE4aBQiijt?=
 =?us-ascii?Q?ZBGBJlYuQ1j6AwoML8oAbLYFdBtL4mscAcXhL8GZJs/sNV2OJSshL6GS+yYr?=
 =?us-ascii?Q?RlqrmE04wH88pgkWHILehnpLET2g8DOlXIGjr1gpGzxDdQzC8FYWTfNOliwX?=
 =?us-ascii?Q?AODesCyByLaF8dGHpsFv1mumLTmDx4ucw2/hFnuWCsXCRtvlGpBh4C6Zwo3/?=
 =?us-ascii?Q?cW5y6KZIO/ATUG0LsawfoVc3cEsR+fwoHrPZX0yfQOFAfIuR3n9tJbgKNH/X?=
 =?us-ascii?Q?VNBqs8Gp0JInUh2jDgvJzsBqT8Qs5YWYmcUjuZImAiA1fW7aorW7Fy+EDHHO?=
 =?us-ascii?Q?1vvSeljJ0STzSrZDcXhj0WE9qp9J7kQcei2TRqngn29TZPPwHHLcjEjO42zD?=
 =?us-ascii?Q?0VTjsBuUmVFjb9nScq2wfLMh2agx2n81ipm1Eiv5RCpEIcAZRGiiqb+GggXX?=
 =?us-ascii?Q?bJUuvfpgMxQ4ZaENfWqwYuq8hIWw3p6m2jeuYxa5N2gcagt4pfqmCxLqvwaF?=
 =?us-ascii?Q?01sFuGZ91epzByz1y5DwSl/epPy3yCOWFnxCVdfqFmPJRQ5xtPHJQQE23vnw?=
 =?us-ascii?Q?aoZBMUGKs/6nCW0ZoZbC8JdugR3MNnMLVZIdilbVVmLiNmQdEhf4AWs5PaGY?=
 =?us-ascii?Q?Yyfu8qh0EmVP9TNzTk91RySLf1wxvxF7IakUowvgcs5oYsf7UdvhiQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1451.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jUu6VpDtq2Hj+8/3pa6HNym8HWYiBXV061PEDyPEYgzMB6jXsRq92k83A1cv?=
 =?us-ascii?Q?FlDBjl+t90h4waNcL0rV70kUHIEj/tgh6ZQX0RFKGD4/6EHC0EoUea9SIWC6?=
 =?us-ascii?Q?nJceE0SwuBkydlCZ1O1DdfaWvBtieeEDXimFsj2reAul23ZZqWo+C5XzYgYO?=
 =?us-ascii?Q?5vD2FUuUNByutw5zVBiQ/tX1nAn6S3bjvs+WF4JpjMR7EHSzEQh5JlOdC690?=
 =?us-ascii?Q?oaWWtbOwZD1v1IxcTUdfJbf0cpsQhnt4yR9OfaQiXqMouR6U1Jca6jePZGtK?=
 =?us-ascii?Q?+Mb3coGp6Ownp5nKp2EIDpNLlQs0Jd7mg00PRLNFkrTVKkkRNhjrbeK1mlcJ?=
 =?us-ascii?Q?XiQTaPAWxNN1xzKBmh5fbPrX2L0PXJcB+BYHySsLi4h4bYQL+ds0YQgKd5Ha?=
 =?us-ascii?Q?7r2sDslv0vl/pGme+yHQSCTvrvhiIH70RZjBeoi+N6NsshAgHxM+Vu/qRRQq?=
 =?us-ascii?Q?NkUWM9GvoK52o6f6Tp+K9pFAJLzby5haVPPKfoLsXoHNa3xJki4fOtdEsGfg?=
 =?us-ascii?Q?rE1AdkI0sn8dW04CuJj9nKefC5AXaedzWwDXyfs2Lh2s8GnM+/QVwPo1un5E?=
 =?us-ascii?Q?hiq0q8QEnCbmEMwEMzbjqH3qDye6B5i681+Qz3tKjFgdO83cMQf6uunPweIa?=
 =?us-ascii?Q?UfEIF2vCyD5CJVjbDfW89g6FI0Pabl48YnpGaTMD66MbZxRFw3sP8wvokjq/?=
 =?us-ascii?Q?Y96OEEBu/xok7Yk1ao3eXd6+bMplT8+/++zQ2a6Z78OzAVrByQc8aO7P1ODt?=
 =?us-ascii?Q?c5+GqXJNNfcrWQQUZWI1Rxf1xfxVJ/w8LGl6/+OJidHVqCyDA6r65a19XSyb?=
 =?us-ascii?Q?V64Y4mjrbAjKiB/xVBCjkOAuWtiknTCjtfp1q3AS743A68p4HeSp+xSY/ug8?=
 =?us-ascii?Q?Yxa8ue4t1LdN8auo+nCVJ5nVEHn9HzdrA4ftgE+ZVvSjk6Mx14r4gUSh06Wr?=
 =?us-ascii?Q?I2G0vw6QtgVWZ5WORHdQM4NktqHD/K7JP/VgyOa2buARLlb97uU5Aea6f6Cm?=
 =?us-ascii?Q?iq95I4zf97D50bW7ftVuRBYJEVDTS6xOWMHnwLpVpJXIF4HJT7ynxey7x+M8?=
 =?us-ascii?Q?dxMZMOn7HZeXbdwxM0eQ9lnwDZPOGJR8pt1HxHhH1W2J2IFkC2i7hH5vHyaE?=
 =?us-ascii?Q?yzy3jcQJcWTVX1utf7qFsJqLVwqn7g/emipQeqiCOqOUM5m12LMP86yROblM?=
 =?us-ascii?Q?ARde1xIxTSaQxBLnJ05lFwQ+jL2aIc4BUt/jUY6Jo6bVe40HXmU5JKaw5abw?=
 =?us-ascii?Q?Q5r4AykvVqflQtMJ8ifOGHicbovbJYRjnR4IVSaL1fIyOo1GuIvlf9R2xGAW?=
 =?us-ascii?Q?Os0MtFlfXM76fyTBrPVT6+wS/8fkj9gAm9vEzd7M3fjrCusIAJeux2sRzbuA?=
 =?us-ascii?Q?AZbQbMjL0/L5kAbcidXoEkJK1ptChc+0PTnsLeEuM1ukMSXm0Mh0pQoCvbjj?=
 =?us-ascii?Q?ssDtZ7b5oP+gAWqeCDEx9p/Gd5rsTg9gEAaGG6kNvjk1BFIR7BTeitPwvmh2?=
 =?us-ascii?Q?GEsGUbqyAd+j/giOwCPI2Nm3+qAqWMaNXcTtw4BvOe84YQQRffNwyTO8gkCi?=
 =?us-ascii?Q?WC4UQwPfFkK2wtSpTgxLuOGpF+KxF1erOCViYpgF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49751c17-34a7-41e5-af64-08dd72f5ab54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1451.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 21:22:42.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z9omdfilolqcVbNUMwDOK9xcF8tbBE2/2cB3i4rkab5gxfkrYTTdHupQRgiGj0+0hx7DtA1d2s3wq0oodtN2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3154

The page frag allocator is not designed for fragsz > PAGE_SIZE.
Explicitly check it in the function & document the fragsz limit.

Haiyang Zhang (2):
  mm: page_frag: Check fragsz at the beginning of __page_frag_alloc_align()
  docs/mm: Specify page frag size is not bigger than PAGE_SIZE

 Documentation/mm/page_frags.rst |  2 +-
 mm/page_frag_cache.c            | 22 +++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.34.1


