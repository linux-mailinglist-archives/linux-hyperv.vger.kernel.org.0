Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F546747A36
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 00:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGDWpl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Jul 2023 18:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDWpk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Jul 2023 18:45:40 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2113.outbound.protection.outlook.com [40.107.10.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84661A2;
        Tue,  4 Jul 2023 15:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTPfWWzpoZN3cZVnzyGxmY5UlrUjMZ5q5ohnLdMU025vFo0k3OQdyiKOtuMpZqpRNBP4J74QvHmsnxFtxnpR+i/aMcbVxvPzvbz6/O4hZdQ0T2qv+ZeuAR4a5lMoorawpTUoZuQhqNJSc5HG0oOQAbYtA428H/u+cJwAY7dNZXEeNW3DzTsoBuCLK1n35nt347IkTZTGvHi3DEiDQwQWL7ugZ9hMnWpn6jDRGnu/0cIdvfIuzNLcnnw7DNePQ8qTlv9AZRF2LXyNnJmSpmGhOhRJH/RKW15myKzgmVN7RQiOXe/Ln+1XrzcMKfO8LyRogRBlobt035ngfGUuJ2PuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMmS1XmUp/qliaemjfZXLwvRh0SKynwpd9IRFpx5ExA=;
 b=ZU+KMTs3fpSZzLyG/s5sIMCCwI6ik/6WWEk+NGL6Lw25yXOQhmuzxTcIFkYJJmbgGFZ9HtM2fDhEf1bdJW1SYY4fERmLrunPKGoQmb+gtJ5YMM57YirnCl1DMCi1vQBM8Y3Cg7RIfvvNjxFUfLz3tvwbelkBCFE7BcC8E63F19R8V02BMWWS3BPgE6o5ouxjyrlMsKiT42raxvx8AzEhw3oneMRbWjpsLADVzt6OoooUqrkQ9sjHAIj4iYit/QJtlNZ1cc4/gU1Nm1T5VnjKhd9GET3na0nIkfqBKCICVJ3s43DowZ2cSNesqSBHW8D7J1NQ/8+0CuGzOl5CBTZlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMmS1XmUp/qliaemjfZXLwvRh0SKynwpd9IRFpx5ExA=;
 b=Ry/10bPOUP1GTbY+pgwH39PCpnC9lCZ+AH/7vA2mSoO7zcAK/K8a40VgsZ/0708pfLaERga/mlKRFQ7mDZ4IFNaizqsLyImSbeyzyX9atdMALKsZl6Qyf8oBuqVwHY5lUNWrx3S0W2fLPeKtiipnlfGqDm/NvTM7h1a0mjhsgd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB5934.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 22:45:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 22:45:37 +0000
Date:   Tue, 4 Jul 2023 23:45:32 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Hyper-V vsock streams do not fill the supplied buffer in full
Message-ID: <20230704234532.532c8ee7.gary@garyguo.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::34) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 37711ea3-b866-4a83-f1e0-08db7ce06277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3Wc8mPhJ6lJLDJB4czb6AfC8e7VNoOMKU5LYFnD6BcO+pRabgSFAgj/jRB/1N2shMaVxFQO6VJsT3RO6SbVXEqolQp1+gR4KbhgFURcIM1V2U0DQnhefRDOnvUohxm9+yEUZoXjuoIhleIvGoKHMAFWVMmMUukhhvo5z+2oHxFmsqoDdG24f+dRkKlMuV44LfPkS5EDAkeSYndjbA1cdMTxEzEQSD6RSo9vAJBazXTnL7KvSY3/R3D85RBNS7FiAt9gxTPWmObfKQ4f9RL94sJ9MJbLu7OkFi31D6V7dC6+r8HA41Bxjyi1cHZGrk6l/a1b9YzQW0uzxdzeOPMu7vnxIHwnLuII1CwUZ006T1FRAkXYZzg1vXWZkfQVuiVddy8GUJ9+Lm0EHyN2js+OqQX19+mPp08M+bSeTwDIvguzuc+W7hMDN42yZrVOH/tv5ADhgUmlu52Z39IT/9aOp7PvcPP9WRGRjptVE6DaJgoNfcAeHh3UjWMQ8vKlKQTSEiz+4W+vMtWvW6YcY37Lvsn5mOlPEG6NuWVeOOo0eQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39830400003)(376002)(396003)(136003)(451199021)(41300700001)(86362001)(38100700002)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(1076003)(26005)(6512007)(966005)(110136005)(478600001)(316002)(36756003)(66476007)(4326008)(66556008)(66946007)(8936002)(8676002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5kmgmdU1A89P9PciYl2fejpPWRGiXK8jyEgyTLgCPi+1mpTx+TFJQ2FJpta?=
 =?us-ascii?Q?6s8fOCd3fBJnOnqh5tcCDf4GcuhwNxPk0yjUs4ZZZVJ5R4qm7ExRTWb59e1d?=
 =?us-ascii?Q?sU9z09OINdILQhAOrecy4QMTEdmHPGJ6f5ZBo7ZuVep7gF1tg9IE9eNOeEiZ?=
 =?us-ascii?Q?MfNIrsmzvO0bVozIS/Hadsc3CAwL9xhIoqQfAQaMUJ75y49GFfwlUKTKZAKr?=
 =?us-ascii?Q?DU1AF9Whyo2rpF5d57Veahq5ACnY3XiL5spZeXgPBapaWAMfGT8c93vHRmUR?=
 =?us-ascii?Q?WkKs4RkQ4l8CQAHUVXt/3lhaKoLgiYFRvRQTwgu3MTJdAbgC5O0ws99owJ65?=
 =?us-ascii?Q?ZtCHdeN2Ck5lMWZgCKeP1nV7vP05Ds7F86ec/leHfqTCKizEI4lB+ctj8nrB?=
 =?us-ascii?Q?MJaQEyojM21iBGSUW36ZbydT9BAiO7qlHIOha/MAOJp0U/BIVwBsoHGAu4VC?=
 =?us-ascii?Q?LGVlrhSasi5mebJwncKwOVjaAMmbVERFSLd3vqR3xMyiOwRbEdKv0bNmfbEE?=
 =?us-ascii?Q?RDbsgvfHaWuCNbywYYc/s2hG8GfFi5cVeAFxERzSqfPBRMWtrVQwVxBGMf2x?=
 =?us-ascii?Q?9eAbG6Efek8BKV1INPJQRAHIiLo6YJ7SGvlCJ/0kM3nbbpz9yGSWD8sgTFCq?=
 =?us-ascii?Q?4RTwFE1YaL0sWSJPrLhZQPUnx9SojVs3YAzLZjPEGyTrNUMnc8dS9H/L6gae?=
 =?us-ascii?Q?M0ZU9SJ2invh1RMLCiAsx647lu1j/7FScobrIag0htUkC4y72UHAbqAlD3vk?=
 =?us-ascii?Q?rmy8a+MDQ9e3kidUGAnqqHWWPg10pfyTpOFnDa4D7dS9SZqFQRlk4jpQCNMq?=
 =?us-ascii?Q?xw3Zz6q9ErvG700URIU8RSbsWe24MQ7SI6/5P7t+ifbk6sqXKl9hbRUrYAyu?=
 =?us-ascii?Q?AdWyc/8jb6lBH7TYe/aqhI7SPS4ZHtNFOr2NAY6a952kaPe2sGmYVi/z3DxP?=
 =?us-ascii?Q?8C3iiBEWUVbZuOa4dwTRRcEmw+AHmsQ37yacnHzLf4FPALbCJxfMQ/iD8eU/?=
 =?us-ascii?Q?DuPkZnyozkVM9UXAj9nuJcRQZCHiwurYablrzgMIQsCr7xK89tsvvVkhu8YM?=
 =?us-ascii?Q?6khnLHAS4YAvTD3iZmXItyz+24LA+p5lH/ancprZHV4/H4czhA5cwDhUazwn?=
 =?us-ascii?Q?y+FwyitViYH4r9+qDS6R7S6gnZif9fJXVpoifPfN5VzV2bq5WpVf1wzFMYiL?=
 =?us-ascii?Q?b9s145J01GExsP97Z8vFJVAj859dEzhJigcmv6GuPDthqkSq4WZDU5Ggzgfa?=
 =?us-ascii?Q?a9mf8+Qq1nbzHjk8EWIK7dwR+OHuBhTO4sncRs32gZ77ydui4cUDM2OzXYGy?=
 =?us-ascii?Q?/V5OEKWbtasf2r+bZczWSInN0YIkAeB1jGDTCD6yn55UoJ4UM5W28JTYpN5H?=
 =?us-ascii?Q?KkI+FMKC24kTOqvuEzmZWO2GjevhzxBU5YkgYEM+eSx8LKOOurkaOgFOc7cW?=
 =?us-ascii?Q?dtBBPMNtoEGGsUtpw8SFKeLq6kHve+Xdhfu3zsYq3V6HZrX4ChsC+vTrOZyl?=
 =?us-ascii?Q?m0biuz+mlI1QIAwfvDZCZpBtLBYP8o67r40vpuzHZkFLSRrcfwM7DRFFbcIE?=
 =?us-ascii?Q?lMZdtrMFi6rvycAMIfyDwCCp+xNBGM7ODFas/lxo?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37711ea3-b866-4a83-f1e0-08db7ce06277
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 22:45:37.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzjylcBH+N3S89cIroBptbnR6yo5GPB8/d9fQDsPcnzVMDNu1djtx33kKvo1ZkL8jqVn8qfT884gjhIWTxXr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB5934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a vsock stream is called with recvmsg with a buffer, it only fills
the buffer with data from the first single VM packet. Even if there are
more VM packets at the time and the buffer is still not completely
filled, it will just leave the buffer partially filled.

This causes some issues when in WSLD which uses the vsock in
non-blocking mode and uses epoll.

For stream-oriented sockets, the epoll man page [1] says that

> For stream-oriented files (e.g., pipe, FIFO, stream socket),
> the condition that the read/write I/O space is exhausted can
> also be detected by checking the amount of data read from /
> written to the target file descriptor.  For example, if you
> call read(2) by asking to read a certain amount of data and
> read(2) returns a lower number of bytes, you can be sure of
> having exhausted the read I/O space for the file descriptor.

This has been used as an optimisation in the wild for reducing number
of syscalls required for stream sockets (by asserting that the socket
will not have to polled to EAGAIN in edge-trigger mode, if the buffer
given to recvmsg is not filled completely). An example is Tokio, which
starting in v1.21.0 [2].

When this optimisation combines with the behaviour of Hyper-V vsock, it
causes issue in this scenario:
* the VM host send data to the guest, and it's splitted into multiple
  VM packets
* sk_data_ready is called and epoll returns, notifying the userspace
  that the socket is ready
* userspace call recvmsg with a buffer, and it's partially filled
* userspace assumes that the stream socket is depleted, and if new data
  arrives epoll will notify it again.
* kernel always considers the socket to be ready, and since it's in
  edge-trigger mode, the epoll instance will never be notified again.

This different realisation of the readiness causes the userspace to
block forever.

[0] https://github.com/nbdd0121/wsld/issues/32
[1] https://man7.org/linux/man-pages/man7/epoll.7.html#:~:text=For%20stream%2Doriented%20files
[2] https://github.com/tokio-rs/tokio/pull/4840

