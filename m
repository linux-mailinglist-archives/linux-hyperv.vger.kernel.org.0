Return-Path: <linux-hyperv+bounces-5589-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BAAABE913
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 03:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3167C7B39CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88141993B7;
	Wed, 21 May 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WqnR5tmK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y8Vtf0WU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6A224D6;
	Wed, 21 May 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790886; cv=fail; b=G+wyPbOk16+xSqFtQzYHGYwoEdJ44PRIBtv46t8SKpTWn5TXhhhCgNLBfqZfvvVA9u5ltRXtdxh2l8a8paSlhyGpZyqqkB/0j5hd9eJ/mOrAEqwzycnwNn/DDsNPD4TT7WhBv8NfSZd4KIOL1R3qVJESQimpBUJKRJn4OVX8N2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790886; c=relaxed/simple;
	bh=8DtOWboshzM8ayKxei2x2bKPy21viw4L7SRFHQYBtsY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=AKRNXCBot2K8xxbMYhQLKLf+JlqzttQ2uPRlwxTsxV6g38LPT65jhnsNBeY4AJ8zX03eG64yIB/nW0dO18bDM5BIgfDqc3rtrdQ7MaifV2Z7R+7zERqxqN3XTQYJHIqwYET8Vsrw7jtWMoNCp/OB7l0Czxk+BRqbuQ8yDog+5X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WqnR5tmK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y8Vtf0WU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L1KQgT004453;
	Wed, 21 May 2025 01:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HgDAhdlkfIab9nJH1j
	IIjDT3f3ocpjdDH9gBCWuowLU=; b=WqnR5tmK4NUvp+y4V0vDP8qEUUznAl2s0A
	V7JH0oADV6ykKjQ4pia7bnaXL0ZwjE0XEkQE82FGhRRABpJJ/6ZCOhClQ5rW9DoH
	azOMN7n+Fo+nttpPOUtWoHdHyX3AJA9CwYHmom7qrVccGwWI3/q3SDbSAGRFsVH1
	PzVrNEhtD09cRqT17060xoqvhV1BWxw/n18hl6isfFlry1vyGoRReOSdxShtFdFV
	vcLM0pxVSXNiE2g3J/DPKq+H2+bchClKPSwZHVnOKvYA8N1a17ZY6jNoAf6ddJJu
	oDpcKXmglKqrw7xHGNqrG/XzbZURIoV26RjLq5FVFGDwlpFi0myA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46s4vtg13k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 01:26:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L0qoGc023998;
	Wed, 21 May 2025 01:26:56 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwekr8mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 01:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJZjjx94y36iinKkotFqC/HEIKbkPyS8cOBgQsvGXu3ljZhAxPhasiNevJHOYu5HcFge/wIUxyHwg3gyfknsbv3svW/CTXU9FuiDLdUZVNap1lf5WhCEJ964JiETwSMBkKYqWHwVm8fTUaRpKiE5+FnLvJbhoLN0kI6TtV9bweyBWWSxa24Cg/FG4qDzV091nSTmprLWmqDR1azc5iNZaCUG8C5t0+zfMg2w4lWTStKTtzFbpjVh/pvG6vaY4wy/jOMWmo7Pwe5HNbEz2KjADy40FoRDvmY5ji8AVmSJXbOsXXCoPsgHHXVqT9ohVwlk8pxUmRJAfcESr6X3/bnHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgDAhdlkfIab9nJH1jIIjDT3f3ocpjdDH9gBCWuowLU=;
 b=vbmp1TZv7JS5R9qdgrWOcMZrtSE/sjrVW4tFizApnUAr+jRTycMpytsw1iGrk1srZZyurRBoZPar3mWSx7CvbuVYEzddmfjPUGdI8IdZqWb0GTT5/YkHrC3ab2+7R8trJlaYV7o52IL0cuu43/5gdrppFndI9gxWrcvv8XLDQr1liFa9u0ASF+ZAwepr3JNHg9yK/XNAlO+Kbo4BrzaLWrRIogldhQDtYCIUg2S0hWXvYs2MuYRFrYo0CqjdxOrCe9Q5QoCN6qnO2rd0OZTU7YA3Jh5MRliyVUfu+v/fq4RQUQfdtj2/ty4vs9q4pe9mh183SJIlAoGVMIoFvaDHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgDAhdlkfIab9nJH1jIIjDT3f3ocpjdDH9gBCWuowLU=;
 b=Y8Vtf0WUYv+5X3u0H7xFwWhD7QPg4npHZSBxc+/V7sLNyGc3Nw8dFg3cnbzgmznqCQuHJo9aRBrOA/0qeM7g1YMlzjYAq5jAeiAZQv00VW9wAjdvZUoYm8+VZss8x5/sqI5gQMa3lIB0BLqolHt+eoGRN9FXd7xdQ9d4Qj/Brgw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7582.namprd10.prod.outlook.com (2603:10b6:a03:538::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 01:26:52 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 01:26:45 +0000
To: Kees Cook <kees@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "Gustavo A . R . Silva"
 <gustavoars@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mike
 Christie <michael.christie@oracle.com>,
        Max Gurtovoy
 <mgurtovoy@nvidia.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Dmitry
 Bogdanov <d.bogdanov@yadro.com>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Simon Horman
 <horms@kernel.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn
 <andrew+netdev@lunn.ch>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Cosmin
 Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
        Ido Schimmel
 <idosch@nvidia.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Paul
 Fertser <fercerpav@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal
 <miquel.raynal@bootlin.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Douglas
 Anderson <dianders@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Jay Vosburgh <jv@jvosburgh.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
        Eric
 Biggers <ebiggers@google.com>, Milan Broz <gmazyland@gmail.com>,
        Philipp
 Hahn <phahn-oss@avm.de>, Ard Biesheuvel <ardb@kernel.org>,
        Al Viro
 <viro@zeniv.linux.org.uk>, Ahmed Zaki <ahmed.zaki@intel.com>,
        Alexander
 Lobakin <aleksander.lobakin@intel.com>,
        Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/7] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250520223108.2672023-1-kees@kernel.org> (Kees Cook's message
	of "Tue, 20 May 2025 15:31:00 -0700")
Organization: Oracle Corporation
Message-ID: <yq1frgyn498.fsf@ca-mkp.ca.oracle.com>
References: <20250520222452.work.063-kees@kernel.org>
	<20250520223108.2672023-1-kees@kernel.org>
Date: Tue, 20 May 2025 21:26:42 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bdf50d-c9ce-4240-c82e-08dd98068cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2x3Ge1QXOge6uZH1JHBhJm2A5JEyjHFXJNeku1sLST3c6/RKsPGXL9yFm2ee?=
 =?us-ascii?Q?iXAz1XgZjzl/xUHWx+DXWwCj6WJ/o7V44yC/AEWj6Pv4zpTfNPgswDm5nwqr?=
 =?us-ascii?Q?OTfG7vzcGY4pzQ6z7vpF7qdhprubfmyiNxdZMasBtuUo98eSqaz2ozUhjE0u?=
 =?us-ascii?Q?2j4UNgCxxxVKnnxDusxOBLY3CV1B4yUcaHRYHdaAGxM764yl8bIFe8fn76bA?=
 =?us-ascii?Q?5UhrapYYurXnZQP1yc+n4N7YOhY70cyfEwlWY0jOC0SGXh5CRFY0eEQ7PDre?=
 =?us-ascii?Q?/i3xhMt2Dv5jLjkqsC1yY93KH5y63+c/hypo3e6w68XdPx1xaw+VEymdkVMP?=
 =?us-ascii?Q?2cfDD/59FWY70dmiYRBdIRArNZfo/IomORGhonKf8d4k9zqxqBNfaYO3G8O6?=
 =?us-ascii?Q?c1Lwjgmbjr3aa73cDkwuMmXxGL86m3GOdDL5A18ygHy0f2aDrZJ7Exmfznli?=
 =?us-ascii?Q?EQ0FIqxteRp9pnjXb2PK2WJW0NOWXdArUUKc35IKDh8JoWrrGjS+zcUJIncF?=
 =?us-ascii?Q?d4KcEKkIaIioKRAJWXcQcb5SRzh0rxCd0hjGZ28b89Q0tl15v1lqb8pvvoTv?=
 =?us-ascii?Q?Hd1G7JQ61+w9PkXYwSlPVvoHAJmjSQkYBo7PMI/hbIj+uVOtig1pe9exbbmk?=
 =?us-ascii?Q?TmkFEVkcFdjT/tt93fTdXZRPGkpqH0l1r47tvNqc0UDSX00NveJXJgxiSRKG?=
 =?us-ascii?Q?PV9w9GJqRTh0icKEzzy+8TSbeA9CZKztYARVq8Ajc1qooV/KWaQzs0D1JK4P?=
 =?us-ascii?Q?GEfmTaTJx9b4ErLot8HEbB9gIiecwVQzHmLmCmFztQ85G5ZsP9lav06zPcuu?=
 =?us-ascii?Q?+hGhMS7cy0jwpMADZN90C7b705AFzClaPSqJaM8LwkmCUrSbT0qtKIMda2b2?=
 =?us-ascii?Q?HQBrmM1mz1yKebBR7HbJ8UQs6Tv9K3rSucStDA5JCshi/zaqZ+umgjAlSQxN?=
 =?us-ascii?Q?wRg8XOjHseXGElzNL9wlVb7WXiwbbxAIzSTIS7SWCQ8RB5DTuHLS3buV2Ag+?=
 =?us-ascii?Q?ga0cPRVnUV/5KAT4/Imh1O7jz87v3h/UBKeRA5J+wLHIscC7k7Od0ukRwnB0?=
 =?us-ascii?Q?VvhTQSqZb8Rffp2zJL5R4FpkTBDcpc/LO9WotA3pXSnu8IauiIdLraqEnziB?=
 =?us-ascii?Q?k8aCu/+JqBm1ofXNFTppHlwtsm907Gskm2FWR/VPaJqmSyr5GqmV6ZNQhTin?=
 =?us-ascii?Q?N/CNSgJ40EgBdvHdyuk5z/kJjAF9mEvX/zCniOXpWPBGdIgwaBHmoFo0GnvW?=
 =?us-ascii?Q?VNKlZYa41bZQr66KISvWkg6hvbyDMC8rfssOHsv3l1tIppvdcz7qETAuGKv1?=
 =?us-ascii?Q?hNENPyJqiudh83eCTGeHJYIIdW+1fu/BB/QL0KQdgK0avRFmdDubeNtUn8qu?=
 =?us-ascii?Q?6STrjUD9EKiyWBBNzd2DWL1NLDmmeQwMEcgkuX3MHQ8YggCrRfT/TJGfWc4H?=
 =?us-ascii?Q?JWIoiDh+FzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nikHo/ZnGP1eZn80h7+7IK4MUseBo6Wh2KM3ozKu4OzXlbPkD1TjZpehLzMx?=
 =?us-ascii?Q?xwICkmKdD+XX/QBdtbt5ooqDbTOCsE2VV1fP6zSoN5cR0K5TwVQW0n/SRyZR?=
 =?us-ascii?Q?xca2rgGED2gYexyXhYHaeqZvujjMoZo861QJYUoDctntg13S8f+YmU1V5jmM?=
 =?us-ascii?Q?dwEbSfHPl9TBJQ0GW0582/BUnuXnQvv6q3Bn5q6mdKJVcDemSuObEid2A87D?=
 =?us-ascii?Q?pTZDsr5tO4KsSeBYeAQFTC7AxQKzFB14duI98ABcHyrKXHUBl5kcDXZIawzA?=
 =?us-ascii?Q?xtCzAxaF0Rm8V8X1FqeZZUvXsi2X6rDBfI7Kys/uEMlvXoDlxALVsKL63+mm?=
 =?us-ascii?Q?vSKNSUfAz8EDrgLlYIMeQX/qQBeBRIPl8thyLERQHtcZuhqAzQDyH2VKtKu2?=
 =?us-ascii?Q?6trCfnfbf5SM/Uo1u7oMAxBbMfRmfs/7DnciVgf2GdZjRIGhZzy2x06Uxkmu?=
 =?us-ascii?Q?VJJcQ+BPRXXQ1C3w/sJuRAqeDITt9D4h3XfU6yrmJMPj3UEO6mm4654iBORF?=
 =?us-ascii?Q?x10tHGhH1vfZlnx3O+jqsoFili+6Hi2RSSO8J7YuPVMFHxe/yN3B2PQ8hRz+?=
 =?us-ascii?Q?r1fq+N2viOYF3i+Esar5j0VtVTGMHH/3ScoDPkZRJ0Nv81HtGIvwAn6NHMM/?=
 =?us-ascii?Q?FljBV2rDWNOVYFT85JRREVsHa1P1nDes8dySZiFPUryyEvmh9I9V67CQZZN4?=
 =?us-ascii?Q?eRCUBr2r8iNI8SO4+xKbu3NFPxHJrTg0gp5N8Ahq5PQJ9XzpX437zObxYdN6?=
 =?us-ascii?Q?9xCmQnBVaGr/e7Cyas6wWnCN82+euekuTHs+hQ4zIOzIV0vTs3p08s20T2m8?=
 =?us-ascii?Q?F3KKslX8U7233LgLUIgy2+zwGe9lsU7k4zNPGj7D02LPoC7HdihV44omWF4O?=
 =?us-ascii?Q?/27u5g4jedg/8GzsXySZdh/g8NQ6jQJB/WPOaLaJowLJmUaCzg6bGlzMqdAj?=
 =?us-ascii?Q?p2y1W1QdRCyP4dArXw/9PhVQPcIHxs05NQ0vb50jnJ4x8hzk/VaNDWaNYKvx?=
 =?us-ascii?Q?0Pmg+yLZLNNDipYtGr1yl/gf8E29vdJ0F6hlC5NDnDHOTkoi3NRrr9FCL2XK?=
 =?us-ascii?Q?U/M2o4vsNYtIybiarJcWHqQnLMb9kvHwj79vuVNfrw+WkR+jF/UwZTwL7lqo?=
 =?us-ascii?Q?q4WVG5Y4BFUvWGvbassCsD8EwGRulnc5JVvdp0GgXpyFCRbCmusw1awT1jh7?=
 =?us-ascii?Q?D53j7RJVyy/iBDyuYlvlIPaDJ3fU8TtsDkQEpQFmNs6tfdQj1SjY1g3NW/LM?=
 =?us-ascii?Q?EAjMxK1fEBOfsTY10W/0iGgIaCRStUwAj41mLGxl4suirrpDNiGq3lf3G9GJ?=
 =?us-ascii?Q?ScpC8CXozsFhl+201AU6Vb2plrPi5sbyATOkUm+uIQvOSc3OBTZ6j9/RT3+J?=
 =?us-ascii?Q?D9B1jMNW20LZYm2qoR5M6z5v/YshlfCRGOiUTfeoO3gRe+CkPz5jj9lVXrbh?=
 =?us-ascii?Q?RiTiXd6zOOd/QCxChoTxXTYnsPxEn3vDCjKaSxqNwW80/JawBJ/rCI8qt9hk?=
 =?us-ascii?Q?w8gGIZJntK627bveMkvxwZG1DyT7X/gBjEzeqrjC+FYVtaReoEUdNahXgsEB?=
 =?us-ascii?Q?bpn1lQX3xlc4HvI9hv8cmVHaGvNAY0Xbrf532KaDbKiqoN1Oj0p33ICCRLYA?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tsIoYxeq4hQeyjrLZcyBXU8kg1Krz6PO42x0ddap4Jpm9vcmnS9xtvB6E2gO+C9W3hY6SZPb1LOiGoPQiIF32aTUITOHJnm3UqBKSgNN9Y11YX31zFW0G/CLDNUiFRik6z4tieTW7VM3zRZ77KrP8FOiTs7x/rn4XworRi0GZKArx6OFwjC6AG62wIZcc1LZxl1aSt3YnOBYUhqMKGDWdkhgHsWwTCZ6GjHJCRdGeEy6xnUUv/7spWXUdTQvkl03G8UomBOJVghsfOzJQaVKDPBS3l8l8ZQ4Keqa5kwqlmD+Qc6bL0zHQ3K5OIrTUse/UclSuWvAoghG4BNxshS9w5GMX63Te8BCTtNVm7kvtqdCJRcYSKpyKhN33D0PLrCkrcHtdRAyCx9QfpVV3IcUhF19UPB0byZMnQshZgwDi0YLID9InkatStigsCHKKVWivs2ahTmz4KO/tN9wPqBtBl8xzs4pxO33d7biti+lHkYQ64knjmBi6EqUF6CQtdrTjJ+/5VKr/ZhBkwA2+iONUUz1tRPcoMfOhWLLAnPOtaLILOzQcitxu2VI+6D1tVvpPtTaRyS3t9U6Vnmf4BvoKg29azLxUbLSUOHzATfGEWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bdf50d-c9ce-4240-c82e-08dd98068cc4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 01:26:45.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smK/Ns04qDqRmnxRJFjbvzOdS3tlDX32n2HWvx/R3EpOLB9LFYH/NeaJPxqbWkcxSru/gtg6LMJlqZMBQUdgNsNUd2inz/7gZO/sdfRLSZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210012
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMyBTYWx0ZWRfXw6n3Crg82CHA xvZnyemtk7sta5vFByyvANd27A1rRqfRqwuyq8qMv2CXyM5AJb58KyuGie2Hr0viSpcLfKh/2mN YWBLYFABep+1wPQufaSQPoAKJUAwtRiggwJHSullpErB4RxUBM/lX25/f3ZW0w3bC1bpp1Jg2XQ
 MrmWYo8dhdt3jTnJDjto59WqRhgyyMD930mDbm+u5bMwSLkeE6oa7A2I63HoifFYrwXBjhNkE/S w4MQOaa1rKZdqsGOX0V1HQb2IoKc6bs8EEBEViVB9lyKbQIJHoFP7DLtefzEogCVXMqj6+kryfk SInDo+vUR5vahWTd615rTxCJv2TLVgchZfado/nRYvhBhDXQ4MXdClIQYxYT2DGaacC1DGTzKof
 +zVEAZusxH1+W3liwFn27XaBmuP6CY9/rHl8pbR/REBV+gRvs7V1MDTjeM2wh7YMFc3G3sg1
X-Authority-Analysis: v=2.4 cv=E4rNpbdl c=1 sm=1 tr=0 ts=682d2be0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VA8TjvsOcMiS39GMMiwA:9 a=MTAcVbZMd_8A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: ZCtZ2tBTzyO93uzuqkhTbF8dYshJ8q0j
X-Proofpoint-GUID: ZCtZ2tBTzyO93uzuqkhTbF8dYshJ8q0j


Kees,

> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # SCSI

-- 
Martin K. Petersen

