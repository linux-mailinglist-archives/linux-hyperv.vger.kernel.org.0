Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342543E52AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Aug 2021 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhHJFRg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Aug 2021 01:17:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50070 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236743AbhHJFRc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Aug 2021 01:17:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A5B2gv010428;
        Tue, 10 Aug 2021 05:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xfgOR5yL2sI5t3iKqaEn5g06OJKt2mQNNnrhKPh9XSQ=;
 b=VKeFKoi2MVEhvkYDlL/gMkKHSBSHnaXyLxsfPJI5Qm5SJIICbIOpm5tvGkAxQu/c2TnH
 M4brTZQufbXX1Y9ZfpZ6a1NVFlCdK9HS/jYNa4OAzh3wsen25t5/7TefxP26kjFY0mNf
 1TzoTSzrd0/9z2jSeoWTqKQOI4J+lvizPh9CsYsPGlkLpjxbH9UyOmLaDcPseiRQvv03
 QZQ27c0ndp0DzlaEk4ZL+l+o6I5xGY9ogdO0l0/nnWJOGVKttCGeLuvIlUhpLCLU4VrX
 zcTeMPnB9LCCCEKrryuNzOpxJ0aa8K0inbX66w6T6lkeI6g1arewcjmfNU/f/WQQimb8 HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xfgOR5yL2sI5t3iKqaEn5g06OJKt2mQNNnrhKPh9XSQ=;
 b=wV4mtLzLr5uEZTWWj3AeYHdRIrUEYc36EbFn+1SswoRuqzgRT6RIGS/FM3Wxj7rFjdOV
 85k9ZFju40hINtBV9sm9abOLQhyKBk3YPsAPU0wMR1AnwYvmQ7krfjzxU3ROb4wTIDlQ
 liynia4+WfoQYgxoMOjHYQyYt3ZZOvzYCxNigBUVMM8UzBEq6SVc8DlX7Alsz+/ImtA1
 encDiWwNYj/Ej9OELsn1Wtjn+rVOerZGRfZMSQvfHwi3lsvruhMxbHrZbp3EctmDg2UN
 QG2D12eScxnrGvTTs6SbrRN9LfGK6ZomDqwljqIY5qws1w/cDzjXHdIrqzCy3lbGY3Z8 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaqmuu042-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 05:17:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A5ALhW101125;
        Tue, 10 Aug 2021 05:17:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3a9vv42xmf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 05:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mhu1vJYgZ8MVF54z0Cmg64mJYWjRTZqNqquWPSMvLDgN6I7l5qT3EMsjoH2hXMkVRRXKoHB+OpTU7yV2TtgUVSn1Cl5eqkIDKeLSnphz4MiLX+3B+P1IfWCkWSuNwSpmto2OcKz2I+HOw6XZl6Kap5X50v8I8fl+DA4PloGrxWpfbtC2AGmVjdqMW2mSjJiWGznOvhyx17hYj015ekfD6hQyLNGLxVp22NG5T9YfcQB485j7VsnqERF25p+XTl7EOzbxbBykYQPtLvi6jWBYpg0hPfzxLhPPGjkOb67kWsXm9beLRZ8aTrR+DRhAzTlyyldwQAYq/548bstcN/qxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfgOR5yL2sI5t3iKqaEn5g06OJKt2mQNNnrhKPh9XSQ=;
 b=SXh1z9GLDes3Dt9N3h/rOQX7sfdV+oNOhAC9DOs8aNPVIX/+OecBmlvD4eDysDRmTRCOvaPgOuqlbZ8mjf9nI/siJsfOFcPuSzjv/Yc3gR2Y9FBPs6/8qaY0FVeClSy6bOg3+eaXh+vrVniSdyUceMKAaIcBC7ABf58psk7zLknuBNPe9oy702m4Hw3GMiGLAGAmZqXB1UTrwov7k040ZCjyx2FivlubX0RTdusRPQL1fpcuZAvEGVKCY1f+FXdxmrY+4SLhef9K57agoS7lH0dx9+h9FxGG4D/3pM0nf6j6MQhlYejl5A9soqcVR6XklWb2F9JebIiu4c5QJgVz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfgOR5yL2sI5t3iKqaEn5g06OJKt2mQNNnrhKPh9XSQ=;
 b=UZxXeG5vn71v9E+9rCxNMSJlUECvm5JtwEUNNbVGR3NuMRsX65zzjiQRVwU2AOHXBEXWy7OGiZUCfwtZMg7dz5dFV5LGibDCgO7s5AnNQ5t9EW9ugvGq393UWbgu9ap+dapDgjufqnG4Ls3aM9rOsed1tLSlr9BVCDBeg9z89z8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 05:17:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 05:17:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     wei.liu@kernel.org, kys@microsoft.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, longli@microsoft.com,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] scsi: storvsc: Log TEST_UNIT_READY errors as warnings
Date:   Tue, 10 Aug 2021 01:17:00 -0400
Message-Id: <162857260239.5447.5380384072400440347.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1628269970-87876-1-git-send-email-mikelley@microsoft.com>
References: <1628269970-87876-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.mkp.ca.oracle.com (138.3.201.9) by SA0PR11CA0112.namprd11.prod.outlook.com (2603:10b6:806:d1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 05:17:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864462df-c40e-408b-b7ca-08d95bbe1855
X-MS-TrafficTypeDiagnostic: PH0PR10MB5580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB5580B1FB1D627ED7D4A311A28EF79@PH0PR10MB5580.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10W0V1xDpXmpUOzEiC3ATrqACpZ4g1BxMD3zOWa5VR69oMUWtGbC6yC6b0+qF5zYxZftPS2DtD2E6uTCRnIRvZ1SK8VYb4f6J1bJbAPg9/2w5dOTwdpA0OokmF4FqW5zk1xpGgoWa8WTFC05XcP0bvW2FT+rCuYgVGfW1anzqP4qcU7CFqCakD0rktotP5IAlo6RdYOy/ZByslB/Mf12xUeopvaEHbaAMmhQUTcFafWjbBQw9LVsaQ801JxM9LY/tstocv3DwgRT9hN8UYOgVhjosCKZawW5uK7w1FR+ZK1ksPm8Lbrq8GM6OLXIMWq9EN0Z2Eb57leOwDWmF3wvo6fMKTz9/gGcKfimF8W8w9Qk7FgwYDSqphQY4XPpLY5ysn6KDO1hlPEe5Q+SDHuwXC40YNf6f4h3KYAyAQd5Rod70rS6lsUo9IVlHx9bzkAaK/t1FsB+S1HDNeILIlSxb48yK4XWK4StKG6stj4a82BgunLOyDQVuT5tQH40CPPmnZ3M1LNg6rtaPNFzt/3sUnTzwH1tAg7V9D3vC/RCVCXbT3uECSXnJ+4FxAibO2QwvOpNsi+AmErsioJ84Gn4yzdMSKQZZxgA7kg22YElVPgKMJNZLBxYUjENyBEXDhiFKWs+O/oo7zzIbN/K+QkCAAp8uAu/7/zWm7wlcVnUT17pyEGqZB5+BrPbK8Oj0/nPSre2qjs3oHRPqYfudAEVTMVhKtlLltcPmAKExaTztvD01WTyLGusOr/Z//DF/FEQwRqRut/lXSveuRjZtHJrSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(376002)(346002)(4744005)(38100700002)(83380400001)(8676002)(316002)(6486002)(36756003)(38350700002)(103116003)(2906002)(956004)(2616005)(8936002)(4326008)(966005)(66946007)(478600001)(186003)(52116002)(6666004)(7696005)(66556008)(107886003)(86362001)(5660300002)(66476007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlQd3gwaUlRL1drbk9UQng4NFJFSndZVUlzVGE1VFBiWXdkRDJ5d0t0RlFr?=
 =?utf-8?B?dkcvSTVyTUlaZW1YdlJiWEdkRnc3aTQxbXovTXpJc2kyWVozeldhdS8zRWVS?=
 =?utf-8?B?UmFDbVJ4dHJhU0x4ZnFhUlNyQmpZckE2TmFOWXhRVzNWTHk1VkhmMk5pWjR5?=
 =?utf-8?B?YnZEK2xLUUx4ckliKy9rU2U2UnU3ai9wRitsbjd2WlliMnZSUHBndXR0cGcr?=
 =?utf-8?B?OFFTbW5xaWpmMDhzU0x1Z2ZXVHAydHNDSldoRjNLakpHbzl0U3ozMGsrMjRw?=
 =?utf-8?B?aDZkSFNYSURINy9IV2dRdk1lV3JTZS8zTVZINWVIV3lCeUJMNlY3eFdlK1NY?=
 =?utf-8?B?V1krYTBteGsrWlBwOHZhSzFwQ09nMGZCVHZkclc3NWlqckdxZ3hJSjZwWldO?=
 =?utf-8?B?bTI3REdPakRnZ04zRTc0YTRLTGQzZEJybzhQenE5Ylk1VE53Q1JrNDhaLzAr?=
 =?utf-8?B?Mk5uQ2V1WkQ2UDIzMEpFcXRhcDJ3Y2lybVlidFdVU29tQTM0T3VCWmU3RDRC?=
 =?utf-8?B?U3VqelJnNlk3L1llOW0rVk1JclFjWlNaMld3MFBiY1lkVkJpbTRCaTFIMk1u?=
 =?utf-8?B?UFh3SStRTVN6U0FJRzc4Q0hjYi9XeVRSdWdXZElvZEk1eVdMNjQvTjg1STBN?=
 =?utf-8?B?RGFsV2ZpRDVZOHNXb3RESXUyNFlqL3hvNnM3MTlqNThBMTV6VFVIbk5xRit6?=
 =?utf-8?B?aG1sd2dVOTlVOVQxZ3IwRE92Q2krRXBKdW8rVklFUndNcmpHTVlIbzFTQ216?=
 =?utf-8?B?bUgvUks1clR3WWtnd1lyRElrUUtCMkRRbXhoVHE3ZVV0QmdFdlhnTnkxc2Ju?=
 =?utf-8?B?b3RERksvazBwUStWMTVwWVdNeEc4NlNZN3FaRElrNzIxaTJwazdQdkR0cnRB?=
 =?utf-8?B?M3V2UXlxbzgrdGFabVBtS3VqQWVjNzUxNzk1Umlqb3hoT3dzK0ZVdjd1Z0Jw?=
 =?utf-8?B?UzlpZEhxbW50WVhINngxdlpSV3ZDSXVBQkZXbGtKVkNZckhiM2pJM002TThS?=
 =?utf-8?B?YVA3SWhremZwcWxGZklsWTZhR0liOFBDdzVtdk9VT2RVbCszc3YxSEs0SktH?=
 =?utf-8?B?UDQ2RmNXZnV6RklSN2ZlT1p2THMvSkJZRFlqQzYxcGFGMjV1QVlZd2Vkems0?=
 =?utf-8?B?UWRoaUZ5SDRHRlhidUE4Wi9NTXhMSjZCZkdnRnJLRUFLMU1ibVlYdkRCVW5G?=
 =?utf-8?B?cFRaUGQ4aFVwWWxwdDlPcHpCZzhrVE43Q0dFWjB4Zm5Jd2I4aDVjWFNQTFAz?=
 =?utf-8?B?RFVDSzE0c0laSUNwWEZqdnp6clNuMGZDdkY2Ri85T2preFlxbFBRcDd2YzN3?=
 =?utf-8?B?WkMzRmdva1JQbzVFQ2NXVDdPWXRXLy9LTEhkbGNHK1F0T0VsVFk0b0NaWVUv?=
 =?utf-8?B?NjlveEhjRTA5bS9tRkx2Y2tudTh1VTlZRW8zODFWUlh2WXZsWGxnMkhiV0Fu?=
 =?utf-8?B?NkdaNGtVRm4rbXlTR0xlRTBsdjhXV1hXZzFRaEpLWmgrRHNvYUN1ZkNJNE9U?=
 =?utf-8?B?UU5NMGRkeTBjN2R5czNmV3l6UFgwUUY2L1Q5L0Mvcmd5K1BIbEFPYStRVkxH?=
 =?utf-8?B?R1FKNmU0cnpDN2JYWitYMUFwNVA2Unl0U0J3YVhqVFNoQ0JKSUdtZUNYNjNX?=
 =?utf-8?B?ck5JRENvWk9rUkljZzlKVTdhTTVlaTErTDRSM3krZTZmL2RydzA5dHhmOGpx?=
 =?utf-8?B?V3pwWWpCTHJvYmw2dFQxTzBmbnZjMUYvZ3ovRjdNR0k0Wk0ySEFZT0k5L2F5?=
 =?utf-8?Q?heP5N0w/ubQPhUX5ENTmjje6utx4zI8aJk17lJm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864462df-c40e-408b-b7ca-08d95bbe1855
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 05:17:06.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKT9Cvp1wnGzaQVjzw2NMeX+fv3csxlCf2KX3rPdVxCmgXzYwSF9mlzaYX07NCeunXbN/qXkllFVC1cy8v1KVSa8hGzUkMP1w9OwIqNNGsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100033
X-Proofpoint-GUID: dgwxDvhJsIZd0KTrAMziFv27YnsrE_gd
X-Proofpoint-ORIG-GUID: dgwxDvhJsIZd0KTrAMziFv27YnsrE_gd
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 6 Aug 2021 10:12:50 -0700, Michael Kelley wrote:

> Commit 08f76547f08d ("scsi: storvsc: Update error logging")
> added more robust logging of errors, particularly those reported
> as Hyper-V errors. But this change produces extra logging noise
> in that TEST_UNIT_READY may report errors during the normal
> course of detecting device adds and removes.
> 
> Fix this by logging TEST_UNIT_READY errors as warnings, so that
> log lines are produced only if the storvsc log level is changed
> to WARN level on the kernel boot line.
> 
> [...]

Applied to 5.14/scsi-fixes, thanks!

[1/1] scsi: storvsc: Log TEST_UNIT_READY errors as warnings
      https://git.kernel.org/mkp/scsi/c/dbe7633c394b

-- 
Martin K. Petersen	Oracle Linux Engineering
