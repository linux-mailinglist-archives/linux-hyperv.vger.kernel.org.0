Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34FA5FC492
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Oct 2022 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJLL4K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Oct 2022 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLL4J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Oct 2022 07:56:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DFBBF01
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Oct 2022 04:56:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CAYNST010338;
        Wed, 12 Oct 2022 11:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=z5FTXKFFLT4N7bAsiH4dErfKMOlF8oGx11c7AFSK8LM=;
 b=UjdLRlUh/E2mr0mPEWWIL+NlKSMRvFYmiuSfHH6gTwdUIL/VDqpsY6ttsDYPUGSThI3s
 ACKwFhitXFcJzvvFubnzXb+1WD43HRBeehyUEiWwuFYL7TDIUaUTVvGqDlC5OXt+xUrF
 i4FP6UoirwRYCIQlKtfZDXx6sGk9P7V7jTIafKIaQDM45uZDT5c5o31AV6xeXEqz7f5q
 VfZHDrKmWFIbyQoAzsHoJ1qFGv3Nm8bf3imSBtxmjViTxKMXR0iF9FKqWdDNfLmTZbVF
 2/E6AFDAZ+5Z+Vtmx5g6CjqRRTmTi7zwm9n8tS3ZyGEqocJViCD7t1tZFlrblo4Epfgt OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30031n5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 11:56:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29C9nxGb002933;
        Wed, 12 Oct 2022 11:56:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn4herj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 11:56:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tb0X17iIS0IVNBXl2WQLMOQ4TALdB3XWFhT3kKMbeuhN/DFtVV+ItIiyuVEgUVtVdTsxR6LDmJ3MOMsAfjhI8CngAqRxYSOfFj9RAqoE+eFYstyRuganRg7vgsNSBAC3OTEzVSG0dWAFZv6gA31AwGuLgg/gMGpSUc4OygZv+N0FolM8esjp6yX454vn6B4XOfENFpBc4EF1vwqhOEIK/p3M+qoU6V9Ei62QL3h052oC/N1Q5hDUf7j5YQMsn492LKNll1wC8RVMhPOuBBdDAmaDYuvodVZ8KdRQm2/uOS1gqVd7a94EW698e4ex8RxZ3TwToLtEGb687YqZb0uW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5FTXKFFLT4N7bAsiH4dErfKMOlF8oGx11c7AFSK8LM=;
 b=Y5A8kay+wMZtMYo+gqFIBoZZIhFsITPOweAZg8Zuz3XyJ2oheQiNqQz5+9skHOKkILJ8DlRTkNt4LiRNzY2wAjMmDY/6b9NCOeLPHurRwJlMHN9Uhgb5V1RAZVuynOsMr6N1X6U59Mn3nnuOBbWAZ7FsXY1h2nq09LjD1M0GhViChh2b+3ekvDZOVnI5RDzaouD5iiqExV3CdPMlCvzJk04yzVBuJiQCE8PXCSiZlY2Ybdullci+M0/sqadjUf9VKYGsERS7MbZYOaIvdCkqUBB+rBpICk93VscaWQk/TFv91eIOIQgoq7ZiG+2X8kds50saDFpnK2R5mGl9Iz2JgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5FTXKFFLT4N7bAsiH4dErfKMOlF8oGx11c7AFSK8LM=;
 b=a17T/Ox0cG1GSJDZU9pBkPRW5xyU8vfPWhSB8fwUrHNkzVPmvbumTdl00Osxr5zzvgB/zZ0zPlsSGRc3Bc52j6C9SGUZbKPVnB5x/sxhTqn4x8jcmXXzr63iLDuTR/+XAtNsokKTpjJgnNzzODfeN436Sz94J5ZwNWphgZJt3zY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY8PR10MB6465.namprd10.prod.outlook.com
 (2603:10b6:930:63::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 11:56:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 12 Oct 2022
 11:56:00 +0000
Date:   Wed, 12 Oct 2022 14:55:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     longli@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure Network
 Adapter
Message-ID: <Y0arQIeN4aJC+yE4@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0040.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7fad00-b1be-4a54-e0b9-08daac48bb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRKiZYknmTB//pfX5xv7pxRsH85KIku8qVJRdSoRtvdE1kjMVucLebH7J3wAu063XkFRkhAF/VM4glislWLBy2DeMEjDKf17sN0n/yL1uDSc3F/7OcccbyifHu4/AJBwshzvH3empM6VKkHy7NBniFIdULFNRduTLK1JiIwHETDUFFOi9WhJhswedZuX2NukDfNCkKzRAVo9ewTjL/YDRUPGmMvBh6McBaqCn2C8W6oJL1dv165e7oDuAk0XWrVoHkeRFaGZJHKX6Df392tOXYIPU6hjWUzaUVLQRgt1EwqSdpPNFkJpVAOH+q6fyj17O5mp4WpfTx2uMd+13aIwH1aKDRtDZQXU1qV7AGf14E2+Utb9pCpsk/8Liot/KtEGS29Q+NnmqRHp1DFGSDDBCLVYyn0B7+zQ599s5Z4UZK2FSeO9CiF4cLt4vA+Gw90+9guPE9ERWcinIxVS0OH1qnQ07Ps1LQOTZPULMnLH0WypwBhChVgjADqKYCzckcoMrYSb0ZuQH70cy841jqwSEnWBH5maESuyb5w4hCdlERS1h9T6c0t/u4fTJqMpJMvHYtPM/pJXsm+EAOKia5gu/yE9mepbby6DjYPA68cWh6Gd039iZCKBU8aJbEKo9l7hn5iX/XUivZ4hbczUnwYklFSfuC5noDtJim+2ZtoWrO9CEb99X3dtYwwCQWCH0jSc1ND7xTlrtDWgCs/mjjx4Ybi/TcsJgXwKCNGoN/HTvpQyAltvCxhWIivq26altoim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(47530400004)(451199015)(6916009)(38100700002)(5660300002)(478600001)(316002)(8676002)(4326008)(66556008)(26005)(66476007)(41300700001)(66946007)(6666004)(44832011)(45080400002)(6512007)(9686003)(6506007)(6486002)(52230400001)(33716001)(2906002)(186003)(83380400001)(8936002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfZWPfA24FnEiXXp5W1u9AN2xEFqG0ZSPL/mGfBSqJYSqCf+TZqjbxs1OecT?=
 =?us-ascii?Q?E7ql5mFYHeD+nVP2Lm4nvsbQ/jR6c7iqCWLBgIIX/ATfLYxS2Im/HOkxl8rn?=
 =?us-ascii?Q?IYooiLnkPwmLQ0OiiaqJb3cy93B+Tv8A4jUrULMS32pz85ss4/1OWts22nNH?=
 =?us-ascii?Q?RcqT8TC8MV28mUMXvAEZUtzUcHnmqOV7W27MjKbkJYfHvSMBL36DFCEAtW1G?=
 =?us-ascii?Q?2NtKnMBbBjOqTMG4Ewp/Thu3MxowZej7+29GxFK5k+S62BUdFDVrT7xQ2elR?=
 =?us-ascii?Q?srNJ/3Nr1Y/CrE/G649yv3YUlFT5Z2Wm+/fSKv1ez+DGWE0HT9SkSiFMiOsX?=
 =?us-ascii?Q?JQ4ipywXt2l/5QplHDiT//oVA/XPUpKMRdFcQZpp9PiGLRnhLa3cfDwlAQf+?=
 =?us-ascii?Q?pk3OctHLMVQWtlFavNwXY59S9+U68bEk15qKh3DOmyso8HA+a5uu9d1WOmu1?=
 =?us-ascii?Q?OoNNJWD4aZV4FuG04i5g3Atu5U4WCm4KgWdzDHcegpihXHDHFk8SWNkxxP2V?=
 =?us-ascii?Q?yRxZig5PzpX/g/qyIipM3tRinbS4hSlmkPhTM7J+BWDQTt31j1yod23myIpG?=
 =?us-ascii?Q?B9hrhhh+gansqPLi0OXlB0WDlUiDTsDTIWB+/g4HhwzHGnYFPWjEf06QsQKG?=
 =?us-ascii?Q?DqKLtMsT1I496zuv7tP/5ZtsX8zXb8ZFjX14FMJpr6+rULoYrM/yMrhbcBEY?=
 =?us-ascii?Q?wB9SeBqW5mzrM+/6BB6AWTft16H4OfTd42g9KYG7pllrHTZ2xjanF8reHpnT?=
 =?us-ascii?Q?pQaQHwUx5JVW4jpR1HW9N/vCNKlvT7/qPUKvM8iktq2uDHWz6wG6zuVJhD+Z?=
 =?us-ascii?Q?2vy/xkm40+xNRfuwORqEmjQkcoZyjy7LAUessA/PZ2Q/v5qhtpU4I7YSrgKD?=
 =?us-ascii?Q?RAd0L7Dl6cJktpaimtSGbtuVslN5GvetSDQ/qTrgXf3bfBbuVuO1nFUnhLem?=
 =?us-ascii?Q?OPUy6gxALOqREzwED9ONRJC0FQwxZ1NApXO9tvf/w7Ku8uS979qbPZG4ZhT8?=
 =?us-ascii?Q?vjyHgUbNBhi9UeQpX4pwiut4rxir/+ZCEVvuXWLOoYmcMAhKiTBFeYCviu9Y?=
 =?us-ascii?Q?kkq2di+pjynDK6Ks/DVF1UHSRbtN3KsnkLQZ+oX5WcrLODPoKXX9W28+hKn5?=
 =?us-ascii?Q?P4R92dy49pN7iem94000g3QOns3EIOXmg8k718dCGQSXuxsCfnFJM57olaKJ?=
 =?us-ascii?Q?90hrlTCuXNNQOrK9fCQcExydVRJM48F1ElHUuw6e9ndx+YwcIX8S+KCAd+VB?=
 =?us-ascii?Q?GioWspkXIatjmfhcctbS1PzWWHrcx1qCi0gyJdjzE5KefQG4xNcv/U2ZPga5?=
 =?us-ascii?Q?l22putEsOwzaXA/Vxy8O+caXdiqI4FGjYQGmLnL8szAAWMRREdLYVHdU78h4?=
 =?us-ascii?Q?AU2nGOn9DB7l+QLxfEhvgP3zIw47wrgx1EIeU8RNbVucRLpGu+qWjkpBmGwH?=
 =?us-ascii?Q?fkbWzamvDu93xtqsrXyaDxc4+KyNqsHR1Ury5gRyb4/KXPjo+Lx1Pcq2l4cv?=
 =?us-ascii?Q?uuO9HfiI+E7svQvMyxIUoxWd6nEILX06y7LFV37H+QUwxnp0ycAPl/G5SuhG?=
 =?us-ascii?Q?RftdfJSv8h4uaZNL7TVQlL1VUBLseAwfMB7atsWGnD0TJggnebZtVlwcQRU6?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7fad00-b1be-4a54-e0b9-08daac48bb10
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 11:56:00.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+wuuemhrf5S+hEI9mWoUsUeR+/8wZF1zGzugYXQyYbvQqNVwiURyaieYXygu/e4vkJYEEuNhoqL6y8wu5sa626k7hNa6E6yWi1dfrzPUp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_05,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=959 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120078
X-Proofpoint-ORIG-GUID: fTZ5--WqzOc9wQyqc7f_i2rrPGeStlYW
X-Proofpoint-GUID: fTZ5--WqzOc9wQyqc7f_i2rrPGeStlYW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Long Li,

This is a semi-automatic email about new static checker warnings.

The patch 6dce3468a04c: "RDMA/mana_ib: Add a driver for Microsoft
Azure Network Adapter" from Sep 20, 2022, leads to the following
Smatch complaint:

    drivers/infiniband/hw/mana/qp.c:221 mana_ib_create_qp_rss()
    warn: variable dereferenced before check 'udata' (see line 115)

drivers/infiniband/hw/mana/qp.c
   114	
   115		if (udata->inlen < sizeof(ucmd))
                    ^^^^^^^^^^^^
This code assumes "udata" is non-NULL

   116			return -EINVAL;
   117	
   118		ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
   119		if (ret) {
   120			ibdev_dbg(&mdev->ib_dev,
   121				  "Failed copy from udata for create rss-qp, err %d\n",
   122				  ret);
   123			return -EFAULT;
   124		}
   125	
   126		if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
   127			ibdev_dbg(&mdev->ib_dev,
   128				  "Requested max_recv_wr %d exceeding limit.\n",
   129				  attr->cap.max_recv_wr);
   130			return -EINVAL;
   131		}
   132	
   133		if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
   134			ibdev_dbg(&mdev->ib_dev,
   135				  "Requested max_recv_sge %d exceeding limit.\n",
   136				  attr->cap.max_recv_sge);
   137			return -EINVAL;
   138		}
   139	
   140		if (ucmd.rx_hash_function != MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
   141			ibdev_dbg(&mdev->ib_dev,
   142				  "RX Hash function is not supported, %d\n",
   143				  ucmd.rx_hash_function);
   144			return -EINVAL;
   145		}
   146	
   147		/* IB ports start with 1, MANA start with 0 */
   148		port = ucmd.port;
   149		if (port < 1 || port > mc->num_ports) {
   150			ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
   151				  port);
   152			return -EINVAL;
   153		}
   154		ndev = mc->ports[port - 1];
   155		mpc = netdev_priv(ndev);
   156	
   157		ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
   158			  ucmd.rx_hash_function, port);
   159	
   160		mana_ind_table = kzalloc(sizeof(mana_handle_t) *
   161						 (1 << ind_tbl->log_ind_tbl_size),
   162					 GFP_KERNEL);
   163		if (!mana_ind_table) {
   164			ret = -ENOMEM;
   165			goto fail;
   166		}
   167	
   168		qp->port = port;
   169	
   170		for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
   171			struct mana_obj_spec wq_spec = {};
   172			struct mana_obj_spec cq_spec = {};
   173	
   174			ibwq = ind_tbl->ind_tbl[i];
   175			wq = container_of(ibwq, struct mana_ib_wq, ibwq);
   176	
   177			ibcq = ibwq->cq;
   178			cq = container_of(ibcq, struct mana_ib_cq, ibcq);
   179	
   180			wq_spec.gdma_region = wq->gdma_region;
   181			wq_spec.queue_size = wq->wq_buf_size;
   182	
   183			cq_spec.gdma_region = cq->gdma_region;
   184			cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
   185			cq_spec.modr_ctx_id = 0;
   186			cq_spec.attached_eq = GDMA_CQ_NO_EQ;
   187	
   188			ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
   189						 &wq_spec, &cq_spec, &wq->rx_object);
   190			if (ret)
   191				goto fail;
   192	
   193			/* The GDMA regions are now owned by the WQ object */
   194			wq->gdma_region = GDMA_INVALID_DMA_REGION;
   195			cq->gdma_region = GDMA_INVALID_DMA_REGION;
   196	
   197			wq->id = wq_spec.queue_index;
   198			cq->id = cq_spec.queue_index;
   199	
   200			ibdev_dbg(&mdev->ib_dev,
   201				  "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
   202				  ret, wq->rx_object, wq->id, cq->id);
   203	
   204			resp.entries[i].cqid = cq->id;
   205			resp.entries[i].wqid = wq->id;
   206	
   207			mana_ind_table[i] = wq->rx_object;
   208		}
   209		resp.num_entries = i;
   210	
   211		ret = mana_ib_cfg_vport_steering(mdev, ndev, wq->rx_object,
   212						 mana_ind_table,
   213						 ind_tbl->log_ind_tbl_size,
   214						 ucmd.rx_hash_key_len,
   215						 ucmd.rx_hash_key);
   216		if (ret)
   217			goto fail;
   218	
   219		kfree(mana_ind_table);
   220	
   221		if (udata) {
                    ^^^^^
Can it be NULL?

   222			ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
   223			if (ret) {

regards,
dan carpenter
