Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA43F4D56
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Aug 2021 17:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhHWPW2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Aug 2021 11:22:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52916 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229883AbhHWPW1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Aug 2021 11:22:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NEa5J3024900;
        Mon, 23 Aug 2021 15:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=RHbBP+unFtKfaIfierfiu3diWa1H9VMFBXxCAdgbBt0=;
 b=dEBLmOPonreV81mlkeEN/Nr+qlyr50tJtNq0slgvwSmSnAYksC4Q5DrwFpZYUEJYx1f6
 VVQj3xT1DKlLX5j8cjJfq+a4JKhM57xhvB4fsNs+UZQMxF/lVw3qI0kgWNqADs7igJIf
 il87+zNJOaNbAM3AfeyVe2zPODurwsrVxmPCn0LVAleMHjvinEIrSFZp9ON66LzOsAcc
 yuCVIMXmWHXkkt4bR2J9gj6UXolYCL7cLLm2RRH5K2fYE7Pa1yznXUJD5lW96J0HcBdm
 e4XqkAOMbvmGm4l8N0+4f7vEexo7IM152/d69i0P70PxlpKEoBDz8sLwdNqJlLZjdFOr Yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=RHbBP+unFtKfaIfierfiu3diWa1H9VMFBXxCAdgbBt0=;
 b=h7UIOkpH7iALMJRwSSo0qEmYRfkbdLQAIGjYhqA59H+ytv2lUJ+ry9taJIaQMSXdW1cX
 awFw/bnEFOtavmCG3HOFLdZfPv8H/5bzm0g6E9RaQp/elqJUZaW8yddp5YQXqYge9ae2
 U83/89L+JX5S881AqAWqtejGofffFTq0whaXyk4O4yjHwgWHt7LQPS9lHWEj7QvmiLK6
 se+KdlvJ2Mp+u6zSQRUzWGp6bVgWh+0k76AH3E4fnsHrB4A0PsfaDKWqsvjEiO3u7GAc
 4zo2poANVGhDY/J11qpcZkL474ZDDX6TGMPpRO8aDqZULiOl7Mzg/+O3sGZ0Im3gkNHJ 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwfm1uhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 15:21:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NFFLXI119103;
        Mon, 23 Aug 2021 15:21:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3ajqhcuhv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 15:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYSWYSnnk+EP4Jr+cuwiA3uqlKAIJBTbcssf6vUpWFJGapG2XLYZstsE0Tzx5Q7S+HNbzxr7Tl3CJ9O4L4xQ7EcR4p2UvHIaMwP5UjW/wPeIIowBrqZtEezNzjSvbT73bCoHaXcbFC9HKESgmoMWCaseuUu4SGDQFBs2CHyinYtlP/ymV/DlXO0HjmxXFoe7nUKCU+NxC8/ULuMvSWbdRbsq7fpjHLMZcQabGNq0sq3SSa/uSHMzX6cNLIoEqqEmykNEqfBmVPSAvqvLo7cW9t6Ns+k7b3zUPRprUuKz9LdMZSOtIArVmDlJVbMOJY+Ofx95uB8vV0/foyOaaHtuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHbBP+unFtKfaIfierfiu3diWa1H9VMFBXxCAdgbBt0=;
 b=ZoMqUq1WiUG/0xZNH2EH+CKj5Ifybi9wLSP0DTj9p7HHO3q0JkeTEQYHMO+mysGRKjCkd4ZLEpD6o23XFzZV/Z17OBrUGR3oHCnkeelf9L+BuWXTFMocYUWR2iyqiQ9VqYFY6UjRWSKUDTRVGxzISmlHdE6PsvKSGb47HgjIdAZxe57EFzTOHRajqGvjAGQHHoiSPD8m1LYAcnXbGEIjg+jaF8fusop7JBFDsmftboAxSLFqGPHWMykG4RuQXS9HL0GDZIHSw1AwgiUmnIyikmdz+/Iy4styguwenF0RwiFdjoCcNd1A1LzupAQdCwXT7NLPiH5DvU1dvP63WwQxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHbBP+unFtKfaIfierfiu3diWa1H9VMFBXxCAdgbBt0=;
 b=Rtj0oYezW95hxKg0Z69FbZyXa+5drf+ldqitKcpZicwbaPsJEx7wibKzN1Fe+tXjM/U5asr2XuCZeaOjkN+taw7GrhUwDaCBwtG4K+4jJc0AZxhGZ9sg5dnWqf+2ecnfo2sc2mm+wXuuAD091g4KW4u0/bYhU3VkRDegD40RPJY=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4690.namprd10.prod.outlook.com
 (2603:10b6:303:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 15:21:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 15:21:40 +0000
Date:   Mon, 23 Aug 2021 18:21:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     longli@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] PCI: hv: Fix a race condition when removing the device
Message-ID: <20210823152130.GA21501@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0057.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0057.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 15:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af1d6a11-67b1-47b3-44f4-08d96649b516
X-MS-TrafficTypeDiagnostic: CO1PR10MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46900D43581F4BB8199C53AA8EC49@CO1PR10MB4690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1chvnRUv2V9nwtT+pEc0B8RLeHeMFXj5r3A3veOtRA+jP29YDfCrvjXA1G0k7lrqHq6ZQkn7VwnFkANoieYSXmE+KvOQu6+lFwOHqW3UHmLNoEX9Xg2VFoxo/PYfx2Jar6yAjRI75/CtrglwoYIS4p1q/kenf7iqU5nUxABUZ62gYFb0xAFWb1cGBM0Fjy7AIZjRz2iFtVRldbJl5Ezfl632d5phqNW+3Vg+ijT2oPC6YZ7uXa+M9nDMwt993sGtlGU+hETuQgfqql4H7VN+QSAA5hOooMTeXdm/F3Ti3e9lknaVx+W+hTql6Za8eMrDQ9k3SLn9hABNpQA5qlTE10kWQhNqBOBGZHlp5Iitg/nI06Wt26Ufo9QFC1xSXC1xYzRRhMHPFbK8vv5KbTXKCwtvd38Rpb4exHCwYhqa4fU8Pm8i+07oVrBPUahldXBkcdDj00yUIVpTc2cZmYj6ny8M1c1puLZQaD3aKmsnxARNBE7NRr9QQBrkZJUyXz/HGXUPkFITg9OnxQHONv37EOkhjfPMFDA9iMDMTucf0+qOffuhVvmzNBsOpAJNoGMigmEMF/dvZMu+oxGInH22Df/IEsTDEuQpWQMGOyCM/S1FO6YflQ9ak6HSRj4jl/F72wQqlFNx64AJ6Ns6xXvqrX5/S1jPFSX2wWnbliUp+fa8rX9rNFQtgcOeoWgnFvNmR8dD+aQa5sCKzEcVrfy1jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(55016002)(9686003)(956004)(9576002)(1076003)(66946007)(66476007)(66556008)(316002)(2906002)(6496006)(52116002)(26005)(186003)(8676002)(8936002)(4326008)(6666004)(86362001)(38350700002)(44832011)(33716001)(38100700002)(33656002)(478600001)(83380400001)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjDYwmO2RFN7K5hN1Bx0i2nwvoFNAv4W9AXZei94YuLM5JAjt7Bi7jnhgmaw?=
 =?us-ascii?Q?16DQaHe61tXzeesCus1Xlgr/V1LHRdsng5fFzqnNL5PbZIhhJpLR/WthBHkh?=
 =?us-ascii?Q?1az7AUwa7XQYdYZmLpERo4vBnCrgiSGwg/ai2PYWvry1lyD/9v4M8Wcc1UAD?=
 =?us-ascii?Q?e1rTfzy2f544SjfWXUNfSCwYLKXXVFtnbIKjG95n6f/iNCp/EWS1J5Ngh19r?=
 =?us-ascii?Q?Bf6zeW6YBJMPzosfjEZhbBIlCAB43+Gp80ygg4ao+A4l2uRWJ6n1A+pfrl0v?=
 =?us-ascii?Q?HLQ7wtFvi3DKV3PBjpL+jNTB1fMMIM76ZycZbnHI3ab8yDTMh2kovmhdakvB?=
 =?us-ascii?Q?BJBHDt57JKrE1IIRhkN50co96EKkSw14HH+itApgNgvm50tDicEv2s1SuL5F?=
 =?us-ascii?Q?mJM3ONCeNO5JFDfmhMUPhYBaI7q7RWYHDffJ0TTBbpIq5vYckS0CYu8Ljahc?=
 =?us-ascii?Q?pK/CxEAWPLxt+OK+WJgTnPKtfSH+e/i5JWPD/O7jfIn+W55g/V9LX862CzE7?=
 =?us-ascii?Q?HQwOk9hnD0zZxVX5NyaryVl/k2DFyUbJJF8umJ2t6vFJjpR27Yi366rSdXun?=
 =?us-ascii?Q?Ii6YvubkrFJSXQzPd8reHWfD2dHM8Fyjb2uzueH/4ncg8q8/DudOO14GIkTg?=
 =?us-ascii?Q?u7R8IFhoV/OLVC6jFKpeKTYJcTqk513b9s9oU0Dhi/O5Fco45kzFfqOIRwTL?=
 =?us-ascii?Q?bUtK5TSVtkrHeoTYeCI+R1oHy81/IodZVUslridAeBJFLhiyB8R6RkQSwEoV?=
 =?us-ascii?Q?VfNimD3SToil6+hHKn5wmUfq6d92Plj9XN4d+U92jeM7yi8crPVRZd8/97IH?=
 =?us-ascii?Q?Ui3FPA1v/o3lYYOfx2w/k0wfumXq/M3tNadewgG/Qw9PDoIrylW1HONsSjPY?=
 =?us-ascii?Q?jhM6Ig6B7KRbyAYpbd6ASzipnHOLkAg0/OlqmMKRNJgnUWKFsD4cLGtYti4e?=
 =?us-ascii?Q?K2Ftfs/YTw9PRajcg7H3v7kMIjt/BIZRtYZrw8bzqcpOT6aQDW2DYRI8DU1r?=
 =?us-ascii?Q?T9AaKZ1R9tuzk1dcBS2BjqgLlzANJm76g94tGD4RUiK8q6Fjs7TURngL7o9w?=
 =?us-ascii?Q?OGdT0l1+9XJ/buu2bAtfDWMGtSFM6pZDFd4xsCUIvt68u2V5ZoQHmQ7Js/mz?=
 =?us-ascii?Q?6cQRNUHYzMAa3Il2WFMLwqdG9+c8xXwcTf5jAKRx401ADBTg1epwmbh1VItK?=
 =?us-ascii?Q?Kw//YRup+j0nfHmFHSdNlB4EuEsVg9IPaSFY8skl5MDHZ8YIppmrjZhdvXDv?=
 =?us-ascii?Q?Rw1qRtaXt+9H28LlPiFdSBVI702yBoz1NNjDaIm2e7jwRForWGRr7bC2oL+q?=
 =?us-ascii?Q?5vbevN4CFVEQ9l1vCk/N0CfV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1d6a11-67b1-47b3-44f4-08d96649b516
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 15:21:40.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJCpgIWBVCH/JS44tL4kciC38sfN3KIdBDhGXZOH2qUy2iZd9JUqjUTPYZfMHkj4IdQKVwsc6t6J0RSMsj4GhuoAhqOr5sqoFYs227OzGUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=782 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230106
X-Proofpoint-ORIG-GUID: X5YQGyvTqleCQro3nQrrdTLpMUpstK0z
X-Proofpoint-GUID: X5YQGyvTqleCQro3nQrrdTLpMUpstK0z
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Long Li,

The patch 94d22763207a: "PCI: hv: Fix a race condition when removing
the device" from May 12, 2021, leads to the following
Smatch static checker warning:

	drivers/pci/controller/pci-hyperv.c:3294 hv_pci_bus_exit()
	warn: sleeping in atomic context

drivers/pci/controller/pci-hyperv.c
    3287 
    3288 	if (!keep_devs) {
    3289 		/* Delete any children which might still exist. */
    3290 		spin_lock_irqsave(&hbus->device_list_lock, flags);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This takes a spinlock.

    3291 		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
    3292 			list_del(&hpdev->list_entry);
    3293 			if (hpdev->pci_slot)
--> 3294 				pci_destroy_slot(hpdev->pci_slot);
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The pci_destroy_slot() function takes a mutex and you can't take a mutex
when you're holding a spinlock because it can sleep.

    3295 			/* For the two refs got in new_pcichild_device() */
    3296 			put_pcichild(hpdev);
    3297 			put_pcichild(hpdev);
    3298 		}
    3299 		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
    3300 	}
    3301 
    3302 	ret = hv_send_resources_released(hdev);
    3303 	if (ret) {
    3304 		dev_err(&hdev->device,

regards,
dan carpenter
