Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253235F9D24
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Oct 2022 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiJJK4B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Oct 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJJKz7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Oct 2022 06:55:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04697120BE
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Oct 2022 03:55:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A8OJcO012837;
        Mon, 10 Oct 2022 10:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=VPUCu3w2L+RXSaaq6z2rNLTbM/yH2u0AUMIpCedI7Kk=;
 b=LxlrYPZXu2VmaHlFIrqX0ORUTv2bPPa+Rz676NWMn5RKnnLs1nQP1IeZERQ0uR7rsGHq
 hVvCsYurQawI65jAYIZXYQHfV+BwzTgh63jI6bLc42iz5Ul4pafSVlDpywDV+ktiZhf4
 CTV461rwi2rJQc4xZW0OA8chsf7n0x4WXRuFJQBtI3IsYeXpo4cvkYsshP2zXNjLAyap
 U1N5yHo7MxIuAMkc1YfZCS62ELmp8rXkoWBbOQeYnktswRkHfy0VcZMflEljBRTDV0kr
 QhRaR2N+bkG9gz9kKs0gqE7ndP3dVKdE8HRkmyLxG8Abw/cWT1lDrS4oHX66tAu8uBe/ gg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtb8eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 10:55:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29AATJ43008539;
        Mon, 10 Oct 2022 10:55:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2spnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 10:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+U8X92z5RnSD/wcA2rxeJctkaSmzOsWTM0iGiNbVeRHJ1STof4frRnMVZk8HM8bbR6MDrONNirRw8GQZK/WJ23mIY54iQCAaXN3Usvlgj6upcobqsEosp96x6BnI1MIc1tA9pFivyyWmjqmkIuB7JjKAHmRgUoeFnKUbcQgS5j9+WsrRU+CYrsepsXIxZQrVQ6YlE5hsgvlkdLQ8H3/XK8ANNKA3w/fZwL+lbi3BYH5q6OevM9wA1mz3B7fAdOXGmHv/hPmvpI1DwsK6ZCC/cn/u3TqBlgQ5y/yALSV8/roiGablALw1nChN8V9zBT5EUm+CTU6s11YhzHOihElnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPUCu3w2L+RXSaaq6z2rNLTbM/yH2u0AUMIpCedI7Kk=;
 b=jsJGoOFG2G3GkJiNt6izsM4gjKNxo/nuh2knRqzUlD4c2jZzTC/Eb/LEaH5EpnHKBELXdV3iBDSNndtYgjuHr+fu10KPQNcGMMa/LFcZjR2NbNAt1cZxDXtRzqlRQAMqv+RlCGzuCJz+MYQwCZAFI1EOcF3XOBkFcfPt5rgkYsRfQK85UkA92PXsQcoV69eT9y1QJZjXqQwKzOIg6gUkSgb7zBc/tsDq4bw8nG6gY4mxTTSCiQ7kbCSKa8+CbyuXFkl4Fr0vL5tjQ6OqI8JJjCacj4nPP8QU9aYCTv/NhxQEbvhDgcBGjLQLOyoY4qbOC96hPRbEKX6tfshaJuLIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPUCu3w2L+RXSaaq6z2rNLTbM/yH2u0AUMIpCedI7Kk=;
 b=EHAe8nl+CuPhTsQI8qoGY4FsiNE/3728JqWj97niEXS9ycPna/N46WUGsYGm4AmXkMEHYYgA8cRf8C/qhXxeZnmKdBAdLwTn2aCyZiLkiBkDtaFZLVZuRj0waoeHbh3S6OGbukOjicxzl0eHX9LQ1RThRQLobvx36xP8Vq7ghMQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH3PR10MB6809.namprd10.prod.outlook.com
 (2603:10b6:610:141::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 10:55:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 10 Oct 2022
 10:55:42 +0000
Date:   Mon, 10 Oct 2022 13:55:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     longli@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Subject: [bug report] RDMA/mana_ib: Add a driver for Microsoft Azure Network
 Adapter
Message-ID: <Y0P6GI5RWHpaPmQP@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0148.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH3PR10MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 1040eb6a-3727-4148-64ea-08daaaadf9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLBWtUH7mDen2Lze0K0217A987dwFbQ1nnzA7q3ncZ8A7+vjkXJRo1qWWVzDHWoI1CNrV8qiL0nEuh1m53Se7ZRHB+eN+a9itsGa3UOAua7DdSmMFyVX97KU5NLX/q0FtDGQt3nFZ/4P0CclUztsnkt9cBllVY2KK3VEEHjKqcRFpMlKnzgjUsi3X0LiPwk9X3WrPY455POGwonoTgByf4EmgBmdBDSlKbGN+KKF0J5Ilmcx2JofnP7omY7XvANNSq03ecEv2yFtou6nEQbKCoPjCo9VhzNp4KXUYkrySKTfY4tz5flBI9+sflHppr24DyXFom/c4AQp55RAYV0ZXwjvRbcs1URu8V7+kcsR5f3g87WDPgXMjYAwb/3sUwUq41Qe2+niF360w3cliUOzVKIYUvL9IZ7ia+CFog52EvYbsEqiJEZp+5jGoN8Kt6uFVbvZ/WQAxrVFwRETr/WohITFg0ynszjLbGtV4BW8lGbWYusmS0Iv/Pdmlypw7wGI3fTFeHmBMJrQzIlczojLYcNevbS7YEl/a37GaSZdEX1KaGDLfTXHSCrNqFC4JcgGwsfHnj+u+IE6q8aseY1tvEFEGu/HUFnt/uRPqnBYhW2ykTK27BZan9YO/hinFEleqPyHCWhGzX4fr5qzhoAqJudQGdveDQUiaB7ClHS7reGoZRXitBfN9a/Dx9sXXwwXYZrgJ5xC+ExorfBqOg2xcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(396003)(39860400002)(346002)(136003)(47530400004)(451199015)(316002)(2906002)(186003)(86362001)(44832011)(6486002)(41300700001)(83380400001)(9686003)(6512007)(66476007)(52230400001)(26005)(8936002)(66556008)(8676002)(33716001)(38100700002)(6916009)(66946007)(5660300002)(45080400002)(478600001)(6506007)(6666004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRuM2q6O2+yNiQRF3W1TaRcc8OJ3u8o9I+ITzcfzHv7RbwpPQVKEqW4l1cjZ?=
 =?us-ascii?Q?z1/mXaMWAy/bIH9mi6EUpEqavcZx5ArQ3r4tA25scCskgpZGSorzOM+HQ4W6?=
 =?us-ascii?Q?dTRPQhXw+4YnX89tZl9gHJTvVciovPHB5OUTZkV/HF0E2Zb0JlDebpv3f/X1?=
 =?us-ascii?Q?PoSbYQoTlFfG4yWH3gdrZqZsiBMoVooyIigvkkEdWOLxzQPCt3BQzN8Xceib?=
 =?us-ascii?Q?TBwlQvs9J2EvfB5CWEJUHqlufKnjYl+5gOQcURVUEBkSCMMITOiRDRAvEOKK?=
 =?us-ascii?Q?bWqVzMsq43jk3SEherY99zCUu+pXZgkhunYW2aeua60fZMGKP53KVrQfFIAz?=
 =?us-ascii?Q?uWVHB6WYV6vvrt08GhJ9PBbcpSFdMwz7WHLMQJkPUnHvqZp6L7eV+YUhBYhJ?=
 =?us-ascii?Q?NVdg04fplao0P9Kb/arxWY2Zn7Czqd3elQvbs49IIn/vdr++INVCvaQ5qlGN?=
 =?us-ascii?Q?I9/krqGLnmF79kbU6fPg3pqoHfmGwnAQM5jCYSlSyNC/bb2nA998wdMrH66M?=
 =?us-ascii?Q?62w9eNUhKD3EiGQtCtShbRHv6OUQ/jRO9Bphz3cn3RGL1IQIptfBrmEjt046?=
 =?us-ascii?Q?N4eCK9XXdEIEuBof1AQH2sl8LU7n7pOz0nJ4UShSqQWdvuPqe/vQegr8bChS?=
 =?us-ascii?Q?YE9947iWUp+IdJu4n8pz05L50CxpMJUNnJbaJgzbSMsW3mEai39WP//cbUa1?=
 =?us-ascii?Q?D/kxQHRLMN6zrH2w5z7uuxuZSrlNoBXltQ0P6FAtQB5RdAUFKO0WRej7mWRG?=
 =?us-ascii?Q?uVTMNrQsjLps3rtHRxxqp/qn3drSb4lQH+MnwftaoGPQakGsVBoNqQyWWr6h?=
 =?us-ascii?Q?dvRNZzlCdnQvsikuDk0w2oGFvQus35yuGNmzdsoP7O6pVtmcWNOToup7l3p0?=
 =?us-ascii?Q?vm5AwsGw6SGmvudNVX0sSVRqd14oxrUtCQ/jNyV084ae3NjFcaZyoYdVRe3H?=
 =?us-ascii?Q?FtgZuKeVhEpcE84kLZt5I19aXhPSEerhr1FUewxS+lEGETS5rzb5DyXwuS0B?=
 =?us-ascii?Q?UdvEcxvUzu40nx9h+MubFnVvQc7FaHbs2H2dpQQfG531Amo7a4Nw4wqzw/ON?=
 =?us-ascii?Q?bsGDG++i9i1cLHNUW4Dx2caamFYakbQOpTbbIMhs6RPNyETZrL0bFiXuAjgk?=
 =?us-ascii?Q?/4Ipx7yi/lRuW+BytiIJFRv7szz2tjij6FGU3/OvsNclph8s5sgOTYIhT0Wh?=
 =?us-ascii?Q?OSwm371rZYzPyVsF9YvKInyNHqZ8FCjwl1xQ90lRQj9WZ37kTa5+emz/KDf8?=
 =?us-ascii?Q?uU6kZdkZehSml28w8gcBQgUm1TUtHIXjl4fmkYclW0KCRCnZVC4/B8sgnr35?=
 =?us-ascii?Q?Y267M7X08nb3Db4rP2dYlcA9EjuzuoEu1GWNgcCTJ6gvb8lraTsZFvFRZY8O?=
 =?us-ascii?Q?h6cC/rwTquR0mUIh0EXLnFfeVVputssJT/ToHE2trzdJpLrtkTIhaYISqOK2?=
 =?us-ascii?Q?A2ClhFA9jaiGfCYDsJ7H5CrtJ/X5My8U24aKLnhaWuMI7i6VzUsdm9NL7JDP?=
 =?us-ascii?Q?akMmDUW7PvSZ5C8wWqP/z3JznTw97x4dLTogZXBEkCzUZHrZWCdEwLV2fqDk?=
 =?us-ascii?Q?88apDzP94VuQQ4jz06D1Pl5UyY2ybrZA3F1op1emf1WyrZeU7p+dTBoVnCQY?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1040eb6a-3727-4148-64ea-08daaaadf9aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:55:42.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r05zgbfWztK6TbJgfM1LMt9B9x/E1kZA7z8aXzzWU4A4pGLy402GBCdPHQkDJRH+yc4/1O/5uGOpZAr9RCny4aVRIOO6HG3HJ7GozhCGk04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_06,2022-10-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100066
X-Proofpoint-GUID: B73WoWfPlNvXp-HuyyjNAaUSIFabEGV9
X-Proofpoint-ORIG-GUID: B73WoWfPlNvXp-HuyyjNAaUSIFabEGV9
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

The patch 6dce3468a04c: "RDMA/mana_ib: Add a driver for Microsoft
Azure Network Adapter" from Sep 20, 2022, leads to the following
Smatch static checker warning:

	drivers/infiniband/hw/mana/qp.c:240 mana_ib_create_qp_rss()
	warn: 'mana_ind_table' was already freed.

drivers/infiniband/hw/mana/qp.c
    91 static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
    92                                  struct ib_qp_init_attr *attr,
    93                                  struct ib_udata *udata)
    94 {
    95         struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
    96         struct mana_ib_dev *mdev =
    97                 container_of(pd->device, struct mana_ib_dev, ib_dev);
    98         struct ib_rwq_ind_table *ind_tbl = attr->rwq_ind_tbl;
    99         struct mana_ib_create_qp_rss_resp resp = {};
    100         struct mana_ib_create_qp_rss ucmd = {};
    101         struct gdma_dev *gd = mdev->gdma_dev;
    102         mana_handle_t *mana_ind_table;
    103         struct mana_port_context *mpc;
    104         struct mana_context *mc;
    105         struct net_device *ndev;
    106         struct mana_ib_cq *cq;
    107         struct mana_ib_wq *wq;
    108         struct ib_cq *ibcq;
    109         struct ib_wq *ibwq;
    110         int i = 0, ret;
    111         u32 port;
    112 
    113         mc = gd->driver_data;
    114 
    115         if (udata->inlen < sizeof(ucmd))
    116                 return -EINVAL;
    117 
    118         ret = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
    119         if (ret) {
    120                 ibdev_dbg(&mdev->ib_dev,
    121                           "Failed copy from udata for create rss-qp, err %d\n",
    122                           ret);
    123                 return -EFAULT;
    124         }
    125 
    126         if (attr->cap.max_recv_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
    127                 ibdev_dbg(&mdev->ib_dev,
    128                           "Requested max_recv_wr %d exceeding limit.\n",
    129                           attr->cap.max_recv_wr);
    130                 return -EINVAL;
    131         }
    132 
    133         if (attr->cap.max_recv_sge > MAX_RX_WQE_SGL_ENTRIES) {
    134                 ibdev_dbg(&mdev->ib_dev,
    135                           "Requested max_recv_sge %d exceeding limit.\n",
    136                           attr->cap.max_recv_sge);
    137                 return -EINVAL;
    138         }
    139 
    140         if (ucmd.rx_hash_function != MANA_IB_RX_HASH_FUNC_TOEPLITZ) {
    141                 ibdev_dbg(&mdev->ib_dev,
    142                           "RX Hash function is not supported, %d\n",
    143                           ucmd.rx_hash_function);
    144                 return -EINVAL;
    145         }
    146 
    147         /* IB ports start with 1, MANA start with 0 */
    148         port = ucmd.port;
    149         if (port < 1 || port > mc->num_ports) {
    150                 ibdev_dbg(&mdev->ib_dev, "Invalid port %u in creating qp\n",
    151                           port);
    152                 return -EINVAL;
    153         }
    154         ndev = mc->ports[port - 1];
    155         mpc = netdev_priv(ndev);
    156 
    157         ibdev_dbg(&mdev->ib_dev, "rx_hash_function %d port %d\n",
    158                   ucmd.rx_hash_function, port);
    159 
    160         mana_ind_table = kzalloc(sizeof(mana_handle_t) *
    161                                          (1 << ind_tbl->log_ind_tbl_size),
    162                                  GFP_KERNEL);
    163         if (!mana_ind_table) {
    164                 ret = -ENOMEM;
    165                 goto fail;
    166         }
    167 
    168         qp->port = port;
    169 
    170         for (i = 0; i < (1 << ind_tbl->log_ind_tbl_size); i++) {
    171                 struct mana_obj_spec wq_spec = {};
    172                 struct mana_obj_spec cq_spec = {};
    173 
    174                 ibwq = ind_tbl->ind_tbl[i];
    175                 wq = container_of(ibwq, struct mana_ib_wq, ibwq);
    176 
    177                 ibcq = ibwq->cq;
    178                 cq = container_of(ibcq, struct mana_ib_cq, ibcq);
    179 
    180                 wq_spec.gdma_region = wq->gdma_region;
    181                 wq_spec.queue_size = wq->wq_buf_size;
    182 
    183                 cq_spec.gdma_region = cq->gdma_region;
    184                 cq_spec.queue_size = cq->cqe * COMP_ENTRY_SIZE;
    185                 cq_spec.modr_ctx_id = 0;
    186                 cq_spec.attached_eq = GDMA_CQ_NO_EQ;
    187 
    188                 ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
    189                                          &wq_spec, &cq_spec, &wq->rx_object);
    190                 if (ret)
    191                         goto fail;
    192 
    193                 /* The GDMA regions are now owned by the WQ object */
    194                 wq->gdma_region = GDMA_INVALID_DMA_REGION;
    195                 cq->gdma_region = GDMA_INVALID_DMA_REGION;
    196 
    197                 wq->id = wq_spec.queue_index;
    198                 cq->id = cq_spec.queue_index;
    199 
    200                 ibdev_dbg(&mdev->ib_dev,
    201                           "ret %d rx_object 0x%llx wq id %llu cq id %llu\n",
    202                           ret, wq->rx_object, wq->id, cq->id);
    203 
    204                 resp.entries[i].cqid = cq->id;
    205                 resp.entries[i].wqid = wq->id;
    206 
    207                 mana_ind_table[i] = wq->rx_object;
    208         }
    209         resp.num_entries = i;
    210 
    211         ret = mana_ib_cfg_vport_steering(mdev, ndev, wq->rx_object,
    212                                          mana_ind_table,
    213                                          ind_tbl->log_ind_tbl_size,
    214                                          ucmd.rx_hash_key_len,
    215                                          ucmd.rx_hash_key);
    216         if (ret)
    217                 goto fail;
    218 
    219         kfree(mana_ind_table);

Freed here.

    220 
    221         if (udata) {
    222                 ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
    223                 if (ret) {
    224                         ibdev_dbg(&mdev->ib_dev,
    225                                   "Failed to copy to udata create rss-qp, %d\n",
    226                                   ret);
    227                         goto fail;

Goto.

    228                 }
    229         }
    230 
    231         return 0;
    232 
    233 fail:
    234         while (i-- > 0) {
    235                 ibwq = ind_tbl->ind_tbl[i];
    236                 wq = container_of(ibwq, struct mana_ib_wq, ibwq);
    237                 mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
    238         }
    239 
--> 240         kfree(mana_ind_table);

Double freed.

    241 
    242         return ret;
    243 }

regards,
dan carpenter
