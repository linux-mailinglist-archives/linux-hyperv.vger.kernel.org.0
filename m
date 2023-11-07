Return-Path: <linux-hyperv+bounces-711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D07E4A4A
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 22:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955D828112E
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76713C6AC;
	Tue,  7 Nov 2023 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XsSml8ni"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E031A78;
	Tue,  7 Nov 2023 21:07:39 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC096D79;
	Tue,  7 Nov 2023 13:07:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbTrwnSb+FhbJMpLSnVrYJZK6tmA/Jn58eYGdMkLC1sf/saQGPl/RClNIoh/l63rxuV9uhNZQGWMwwiMuViItdAZ/ICN+UCHAf4VCtNCN/c38taGr3+u48nsta8OXJM5WB8r6JS/ekdf6v8msibJxOe50n7Duj8iJ6JbmRgywWkdTyW5FFtgdpOAgt7sOKBkvizWpnqWdClY9jPMWVtvQsytik/IBSrABi9Oy2zMCiNj1t7drY6UZXYGd3g8L+H+HO+YuBaCyUoJqFuyJ5h+YSOERPll1G7TxIvkms5sjK0+h+8Rf7D+MfpaEVx5Le+p1+SnnS78y5mA5VMN+NhEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RSXIv0DFfBlTJtCam5RdcqhVYhviEmhEPskbG14ww8=;
 b=SQf/viWPB6vNb8eObldgCPw/Hzx8w0GvwPwYDq6ug8M7DEPmNMiLxn5UREd2OUXznxD25Adi9p9L8ZA6Z2EWa1xDW2Zep86o9YynmYdUKZMZIp9bev0K4dvCdOPbr7JtZcZs7QKHHp0OpZj2eSZpHoy/nDIXk/2iDWj0H7AZNIHbovVBao6R+8ElrI9GX3wfS4eYANt1O6RRmehkDsvDjtNzdWt7iH28Np0Q8aZdbUTvdZzcKfJh17eE//8hB9QB6s0O/EE/N/4et+la0ShLTUA8o0LHI4Typvuh43ST0WoHFNdkAQWZiF5oksEL6t6ajeyRHjb2ld2nZ0t/Mliz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RSXIv0DFfBlTJtCam5RdcqhVYhviEmhEPskbG14ww8=;
 b=XsSml8niXlOhVXUKQoNPCNog4ofimR+tkw3eq1ET+H88OdkfOivzzS+Udv2YU3/gMG7I4oCW/g182HV/ErmoKBdfEFwtrbG6J7rjw0YyElSWJMGGn4OWqKiUn/kBSm28pHifhuRa3a0ikJVCHLaLLsKqw+WYtIyk2AMmMZqBYCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DS0PR21MB3929.namprd21.prod.outlook.com (2603:10b6:8:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.0; Tue, 7 Nov
 2023 21:07:35 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::e8f3:a982:78ac:3cea%3]) with mapi id 15.20.7002.001; Tue, 7 Nov 2023
 21:07:35 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net,v3, 0/2] hv_netvsc: fix race of netvsc and VF register
Date: Tue,  7 Nov 2023 13:05:30 -0800
Message-Id: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To MN2PR21MB1454.namprd21.prod.outlook.com
 (2603:10b6:208:208::11)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DS0PR21MB3929:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d17057-475e-4ea0-c6ac-08dbdfd58f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fMIZ3mn8f6YCu4EfHOtlSr4Ghd91YJEwks1XXPmdReZtIVzfJmaY6J3C7FsuHPWPQviu9fXrejx7v9pfwF452Z5z8+74MTPh5JhyO9nd/n/1sajmRdKrTiH5vO3lfINgRIrOWSQfhJS6cfyGuIkM0HgZbmizejqFJwgDbseQ+TchbfzXYTAL15qP9opGBYmSczG7RJc26UYaHKMTGBJYvZd3yibx1N0p+qlk7GgT2xaO1p6QIVN1XbsIA0jRUkag7KuIPuaMdeD+fmLvHMwC1HqiPd+2UHP7HOpJen80VpT9edUUDjHVi3arOcQUL7Zjbe9lberagxq573u3CHcla5H9Q7wm0WIrc+sPcz3QWxOoNTLZpWpIWD2aD90P6ou/41Y1FbUsUj4rs0A1ThAc0qCQrd17N4k0oUh1mCc7cM4Y5rc21v9rsMYwBcNFUnc1WBro9CNaePU77HagK1lfiYgiwxFNcS51J6KzrGPNKLmlX6dTuXJAF71Ve/eb8sZIsERKtDTxY4ygnyDy3kBmbCdXltV45YQayO5wpLukktE5M2RzXLHSTTSxLC2D59wyy/qsC3eB+JIMcGiwhRnVAR1QxafGBj+dmc+yHqTHdzIDWVSmUa2j1XVudFbvTVbWTkqvewJjsvBxOm7/VFyU5W5PzC1E+kqbC82Cy5lksTI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(83380400001)(41300700001)(38100700002)(38350700005)(36756003)(82960400001)(82950400001)(52116002)(6666004)(6506007)(7846003)(6512007)(6486002)(478600001)(66946007)(316002)(66476007)(66556008)(4326008)(8676002)(8936002)(10290500003)(5660300002)(2616005)(26005)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpkNPAUV2PuIX1t/PWArvxY/kdeYmJYGuQX2xnxO/fDYalf1UACquy7nzBb0?=
 =?us-ascii?Q?MHX3JU3hIemd2Cjuf8EoG6HJB5imIxCJq0Nhyddc/EmGr5kJCMLHu0Dl5GE7?=
 =?us-ascii?Q?gt5O83RaWOQ4hP8058xKeaAacY1NqUWnGhk4LOXUIpYaNHt+PDZoXlroVeDw?=
 =?us-ascii?Q?fYgvFc6zf0Re9Eypu/IQ+27+Klzo5NqhwmeJhtM6AsEvEUU5A1oyyoWPTpo7?=
 =?us-ascii?Q?9820vzoKoEaCgIlma1ZELlqJdSa59TvW8zAejh9A/J3nx/yedWloprKz5HuF?=
 =?us-ascii?Q?oAr0CfXaFZxKpeG/tRpK4V7FSy/RjtLM6eZseJYnn9aQo8CyYQVjmj3T0Gef?=
 =?us-ascii?Q?bJf9DW5EdZEQxT0AjgFuWr7EY8yIK5YdWE9J4kDCtNs4tEVmatYtsGGPl2hr?=
 =?us-ascii?Q?R80hoc3TnXjkwREn5bBZJiPMKp5tDjC0m4NOGfWn5rVQoWYdXOiBPiMdLYnl?=
 =?us-ascii?Q?sec8XU3F/S7Hb/MrDGKP+SCDONu2gbgkT8O9bPFUCKYaLBPra6u+2VQJXzKK?=
 =?us-ascii?Q?TO4UR7gFWkN+AunNCy422lmQgt0ko/VHJlwMq25kQxALT0HJrce0POm67v81?=
 =?us-ascii?Q?FFwVwEs1aPr/RWbXlIklLprBh+CaQ4dDdLncMTHmPkh3RmuEIxybq470r3Yh?=
 =?us-ascii?Q?bXxqH2uOInEpy7OKgQ7ErmYq3mgl3Ws3VNEXkCkvJC0wBO1MB9Gak4OCl0pC?=
 =?us-ascii?Q?CsjdkdX6hbzCUX8ZCEFG1fSSPkp1iq5ckZZrOaghhpU+RuYM3uXGOWpcph6/?=
 =?us-ascii?Q?hhGtgxd0MioxPvSccn3054U0B1yUtOcVARKO+eEzENwmZO+aXApYpMJChxTf?=
 =?us-ascii?Q?r9Mos8qwwFSHZm8yz1YZhq/JHWOsdgNVktgWHX4purQOxP9IknrdWeu2A3i1?=
 =?us-ascii?Q?7FUyV2Qlmnuvl4L/fAr/mJbPzO2kgzeIskpGaif0YUJVfJ/mhU/sMs2zSBtA?=
 =?us-ascii?Q?9bq7j9NHOeKjyAxMMNMkvLtS3qvJZ3s7XmUSwVLhsJjdbmux3+osBTnkk8G0?=
 =?us-ascii?Q?MhjlqLUkKsZ/MuOi5POr+jl7u9SayZeMCmuAVk7YC0hNZn/6flLBtHdmW9nt?=
 =?us-ascii?Q?Mtb6vk1C8P+H6C9imEsAQoYI80ertB0CyzeVNreG2JcsvLB1JNkfS8ykx1Qs?=
 =?us-ascii?Q?P3V7TKC7igw1R6uR91iZvbUi4Cn4cOOqL7nv1mbQENIMOgdSyYL8F3iqWe56?=
 =?us-ascii?Q?AFzimZ/lEiVIon8Um4xFfCXt/Lp7+6I0ZJC9X5deg/9vYE1RVsJeXzsxFJZW?=
 =?us-ascii?Q?uoQ9qxTqL9gDmV5fZwiIZpS2VRsSTWWVrGtdILnU26IVbVWx3FQVs2bKWSvn?=
 =?us-ascii?Q?53+ZP3eGm6PFuxIk1AkDuy8m1EIkWF321dE+lboVDj1UxFrkWmzBDgLw28Vp?=
 =?us-ascii?Q?yQrb306PckC/hyx2YpEL4KtwllAoLeb9kU09ihFNI0Ef4IzKwb7NY/yDmF9t?=
 =?us-ascii?Q?qWD/j8cYmUanJWAh2YqYiXtYxd7tUOUvlCufY9Prm7wxROWTm+YQ7JtNQaqO?=
 =?us-ascii?Q?wTlqZ6qQpn33GC/UEjXExeaBjthlBr1TlO84MSoe4YGaq/XbFNCjdiYsj2IW?=
 =?us-ascii?Q?cxVwSAsyxiA/WxLYt06S/fE/kNaVMSn1ZgX8gKKF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d17057-475e-4ea0-c6ac-08dbdfd58f4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1454.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:07:35.3240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scY4pKs6mN1WFP7WE0mwI9frhhV/s8UodOBC0tnm0o1OWL6m4zztgBezf0JjaQUvmPtciqkOmBHW4VBlGWSQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3929

There are some races between netvsc probe, set notifier and VF register.
This patch set fixes them.

Haiyang Zhang (2):
  hv_netvsc: Fix race of netvsc and VF register_netdevice
  hv_netvsc: Fix race of register_netdevice_notifier and VF register

 drivers/net/hyperv/netvsc_drv.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

-- 
2.25.1


