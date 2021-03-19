Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9C3413B0
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 04:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhCSDrT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Mar 2021 23:47:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhCSDrP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Mar 2021 23:47:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J3Vdfe092243;
        Fri, 19 Mar 2021 03:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OilxqpB736mKOqe+6p4STpn/vzwfrgaZQWcg6BmkkIM=;
 b=y2VxlftnvouG5hG/x5h0fWplA3fTGmUnCEPa/vW8M/S01hqKhUBy3ag0+zC8HrmI72e+
 h8Y5Ekdcvw4zAu1mDhXR6itiLLvRxS44SKjFdzSoacnuf+577jOt8GAXLOH54mGSvhK3
 vAmBIfzc2BmRi9kqbf0BbSogFU8nSBo8KoYgF0HFox65rBm2/gd/sZAX8qDx7su7Zegz
 PrAuJz3lAhPCwBitXFlYiJ/vI0b2xDyb+0/SjZ9go5jlp2XvIc2bsxg9xwyOlVQ/lcNE
 51d85/rbAVlPimQC532LQaRRctGiMEkTIN4tMrRNfrpI8agg+yl+ocAMu0pDmH5C+te5 GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 378p1p1fys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 03:47:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J3U8cj175034;
        Fri, 19 Mar 2021 03:47:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 37cf2v0ds7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 03:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMHACUBWurmr18wO45OqA4Ftp6KbOyDjOo2eHTwr6glw5sg4L6QwX+2DKauJs8O42ocVrpE4GO3879b6/IYK6ss7vbRA3VeOddCDvjp6fq502Emh2Bdc6EPTClXPjiK+kDzgpgzDsgJncbpaAFIgB3Y5ZhfHXf2P3cWxZf9VktnbPoqf9yiSOUwmYYkBsPYYYxFSrz9i5buK0K678PVfd8yh0UBnyQKsEGt9gmW25G0oX0gY3ylQdhNMhCA/DdGSAJO+f2JKSaHd6CIeIM6XkYr9i+0lbKK1k82g8r4cPwMRPyweRM0PbF5tUPP0tTuk0WVvF8s8+YlHGSj+JCyu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OilxqpB736mKOqe+6p4STpn/vzwfrgaZQWcg6BmkkIM=;
 b=PVPgmzq0h6WGxu15NwlaMDGtS55dOzyPl7sP5bmMJttQFSbi2HK8umQBBCRyKcjuIg8JgOXQtToF7W7qezjuENkYRw4EOOljzxdtfQ6W1hDMHHVp28BPqtlKKaE/HkBAwk6MJvdaNoKpyLvAB1dqvIej0ePCksxq8p4DlNZPLyAW8wnrPLBwLZvTZn5znEx/Mq50scA22NZxqo4xrbHYeRQpYd9764XQ6XwsJwreI+UFZ6Kkg339O7wp/MGi7+Il7xGlTtNIaOP9msoVGBzm8Qmv7cXeCPKsY1YXu9WVvEntgxhfrTHsN0N07+Ygul0s1blFInSbMLBcMyLUGQMvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OilxqpB736mKOqe+6p4STpn/vzwfrgaZQWcg6BmkkIM=;
 b=REQ/fMMq5OmXbrRfkeIODeGfRTBWAIfx2e/xJR7ORs/dpH5io47z43M5iOOERHri+/W6JT30xl3bGGLc0dL0zzt47EMtEC9p8yKGk1DwzgsIzeNbjigoI3dTtzOD4xTNWBr1LMIyJyWjH1pseThBUYdSCEB1Ulfzh1u/2slXiwM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4470.namprd10.prod.outlook.com (2603:10b6:510:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 03:47:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 03:47:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     longli@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        linux-scsi@vger.kernel.org, jejb@linux.ibm.com, wei.liu@kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 1/1] scsi: storvsc: Enable scatterlist entry lengths > 4Kbytes
Date:   Thu, 18 Mar 2021 23:46:39 -0400
Message-Id: <161612513549.25210.13206699806758819560.b4-ty@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1614120294-1930-1-git-send-email-mikelley@microsoft.com>
References: <1614120294-1930-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [138.3.200.9]
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.mkp.ca.oracle.com (138.3.200.9) by SJ0PR05CA0182.namprd05.prod.outlook.com (2603:10b6:a03:330::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 03:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a891a72-a8b7-4e78-bbe8-08d8ea89aadd
X-MS-TrafficTypeDiagnostic: PH0PR10MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4470DEF02D59399BDB65EAB08E689@PH0PR10MB4470.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+9kO0ELKJhgkcKsQHbzPasXkPj9+oMm5IdZmNWyGQCgWLI7x17l6V9NK09gB2RCTMjYc6wbfsMqfVGup07CJciDgIofeTBjIsKXVnbp4nNB8IdD942VxyOMnGJoq62uuQN4GGYGRmLcJRVmq3AW8Wb24GnaVXI2tlLK/4ZKFT+KGposY5AwFpx6LmwC+WaYBOmJO9C6d9w9QDG1QP+LuW+Y91u4QZfGe3p3Y0AILRMUzKVO+6WA5DoLGIQhKE/05n+KL4lLw5a0nYaOmt/DQo1DXftkAt2oQyTV+w4czPu7GARC6w41Fnmbq3ulxUFZz9zB5AOhSpM5rEBcBcariZa0UbnwtENMKcUk/Sw7CEg55qaB9pwH07LPs4AyLBzH8iSlpXwkyEbFAeF+zJJt48g2P54ecBUTUc51WKjUEyKnTqSuHHvoKIwGR1RFtby+eIClsZhRz9g2Dn/G/kt6ly20vX2ub53V/V+FHKd8YS3ysJLtQA3A5lABWWS6w8g/vuJjMph1LVG7hSqfqZ7X74CptJyUcm+CL/IZmehrKlSajV6OSqOJMlZdFMqlxBTEvBg2eGeV48WrBP3hRZBZ9q1rFiy3+BRZzk71f5bNWzMTTnKy+bXj1jACUcf8xSAMVneTMufpwWh6zgQr3G/Jm72EI5P7mc/qYcQD8alSAPnnG6Wl3/uTX8dcbjaoyuMy2JSrulb+aj6TdLU1C8DaMDbmhofIeK2dPN7SiypBu98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(376002)(136003)(38100700001)(2906002)(4326008)(956004)(107886003)(6486002)(5660300002)(8676002)(16526019)(66556008)(186003)(6666004)(316002)(8936002)(103116003)(86362001)(966005)(2616005)(26005)(4744005)(66476007)(66946007)(36756003)(52116002)(7696005)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bE5Bb2RmbnUzZWpBTzl0VjhwQVpNRnFUSUN5WjhrMnQvZkdJaDlQUGUraEZV?=
 =?utf-8?B?MkY0dUZ1TndYMFlMRkMrcnFoWVNrNEpIY2ZMWmtLNlRJajFpcUFvR1JzQmUr?=
 =?utf-8?B?QnA5UmFUa2ErK0N1NDI3Zk9JR3lwN2NkZ0FmaTNEVzhuTXQ2N3piQlpINFYz?=
 =?utf-8?B?eEtwMGdhbm5qOVVGWE1LNk1hWm1RU3c2cWZ0cHNQUHYxZU03eS9JUmZZNWlR?=
 =?utf-8?B?OVhBbzNkSVhMWTd5Q1oyMWJmYllXK1c3UE1YTURrQ2ZOMGg5dFdNMVNvYzc3?=
 =?utf-8?B?SVduN25jN1RXNE9DTUFiemNEQVdDVlpWQnVyR2FHOW9WaGZCWmdHdWxNSTJW?=
 =?utf-8?B?Z0R4dnFocDNvTnBkbFgvSmdlRGRlTURnN1RFL1l4L2JTbEJ0blZiNGxKUzNj?=
 =?utf-8?B?OGlmWnlnS3B4MTZYOHF4cmdCRjMxVVFYNW1PK04yRURNWUNpSzlWV3pxMVl3?=
 =?utf-8?B?VkN3RHFPQzBQZkk1T2pxckloblF5MU5jb1V1Y2xGdlI2R0xLOU1OeXVVa0V2?=
 =?utf-8?B?NzlkbEJ3TGZjZURUS0tyejFkTDhyK3ZTUkhSVEJWNjJ2d1VpaWI3VlJURWth?=
 =?utf-8?B?eU9RU0l3aHovaGRDcllnSmRaeDROaG1USWlBRG5pRWJ0MVdhQ1VSa3NEVHNF?=
 =?utf-8?B?L0w3UVpwdTR0S3RNd29nMWRMSEdRWHQ5dG9pVDFEd2J4NVFKbjZ1RkpSbFVj?=
 =?utf-8?B?UlkwcVE3amhiUDN4K2ZFZnIvaE15VCtNeklheEQ2ZzljUkg4cXhTSEdzMVVE?=
 =?utf-8?B?aWFFM0I3WG1xeVptQzAxNmhSTndzNXhsQktjMUlVbFRZb0ovRXZBWDdIbkYx?=
 =?utf-8?B?VVc2anRjVnJlcW56dlZjZ2pOSW8waThWbDZSRmhybjJUWGRYOFRvWEwrOUR3?=
 =?utf-8?B?ekN5b255UVNTZTNRSG9DbFBsYkwxbkViZUx1RjUwbW95ZlpUZW5PTEY0Ymsr?=
 =?utf-8?B?NEFwU3dIaXdVSm4wRTF5YVFVcmFVQVJEcVRXYnF5bzNHTnlZOVYrUlNEeTVU?=
 =?utf-8?B?cnBhN0o1anZzaUMrRXFqTXprV0xaclV1NlNQemdwbE03NUpweWxrZ3o5SnYw?=
 =?utf-8?B?WTV3SzM1UXFyWUpxZU1PRzlpTlJ5TU1kUlVhNHU1QzI1RkdITmpMSnZZdFV2?=
 =?utf-8?B?T3l5clNuTnJqNDJtcVBobGdJQUZ5NU1GWlRuYnB5SkY2Q052ZFZSVGtSM29a?=
 =?utf-8?B?ZndKbElSMWNjalVKNkxCRWkveDVoOWlpQzYzWnBkNzBZbXpaeVVYRHFjWm43?=
 =?utf-8?B?NkR2bU1FV1k2Q1llQlFUK2RmMTJIb3N3czNDdDJwSWRCS0YzRGhjQ243bGZp?=
 =?utf-8?B?NlhCRzN5TUxIZTNOTWR1Sk5sZVZvL2E5TFBxWSt4L3lSZVU5OEozNEJzVDdO?=
 =?utf-8?B?WnVnK2JZWjltRm90WllTZEhSZzhuazFONG42R1NZZmM1bWJ3TCtuOHFIWXhv?=
 =?utf-8?B?a2VadUROY2RFcU1PTHZKU3l6cUJHQjNYdkYrN211OC9VckoycWlPVFZQa3RN?=
 =?utf-8?B?RTd3aEI1SXVLbGdIQy9DZDlYSWZiRUF3bVloc09wdExwaU5VWEZ6RkU4MjZt?=
 =?utf-8?B?ZkRaRXlPRXFQWlh0cG1TMGdoamgzczRvc0tsZVQ3V2dKcTk3YjgyUTdhOWQy?=
 =?utf-8?B?TGpWSWtBSlJCZEdOaTlTUnlCbFhjR1FzUDdyMnJOM01PYlArakcwUzlhMUpB?=
 =?utf-8?B?OURMQTQ1VjZOcEJTK1BqV1N0ODN1MGRHVjJKK2FoeUhNaWkwYVFnMzdpK0Y2?=
 =?utf-8?Q?6LxETl/EpewUaGREXnhQLzYC3lF+uE0C9a2d02x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a891a72-a8b7-4e78-bbe8-08d8ea89aadd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 03:47:07.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZ/M+p/NjVBzKMATC2bYxMI9jJU+A1K7R6OnxQaJyYbO5v9Wedz3NnAFZIvfSpFA4Zgrkslzz2yL8dQj+1QNjQoDHjVvocbu2YOReW0sqR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4470
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190023
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190023
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 23 Feb 2021 14:44:54 -0800, Michael Kelley wrote:

> storvsc currently sets .dma_boundary to limit scatterlist entries
> to 4 Kbytes, which is less efficient with huge pages that offer
> large chunks of contiguous physical memory. Improve the algorithm
> for creating the Hyper-V guest physical address PFN array so
> that scatterlist entries with lengths > 4Kbytes are handled.
> As a result, remove the .dma_boundary setting.
> 
> [...]

Applied to 5.13/scsi-queue, thanks!

[1/1] scsi: storvsc: Enable scatterlist entry lengths > 4Kbytes
      https://git.kernel.org/mkp/scsi/c/3d9c3dcc58e9

-- 
Martin K. Petersen	Oracle Linux Engineering
