Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89B73AB8E
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jun 2023 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFVV1e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jun 2023 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVV1d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jun 2023 17:27:33 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4561BDA;
        Thu, 22 Jun 2023 14:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRYPLJorA5uPOlbcxDEygJmDa2NeqEO+dyjFrxFkMTnZ0E8kp0lBlkaVpfyUWJwjRpKDxeJAiGZ6CTjz1mQcgi998SODiTKRmsRS/oitPSKjGX/2NvYjwd60jTckVoSXEAX58LJvHw5wB22WOwKfoONkcFPn9okm8PBfefRLrGs5LuN/x1+z6Rr1ntl7XOEk8Hgb8S6ER2mzsI+BUxefrS1Qvf1vQhDa0nSHtZ/rYHtIcuqEr9LQsrkAA/1bcwdXFeGtOY/PcdaW4lWND9yibAg3pxXb4RzNPKgiTNasUSdNqa56bCsVmGCMEidSGrNA9qYMxWGD6wM2InLKohOVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Azq+5820iPkYK3GsujyUq7ZhL5EfXe6T+SrawhZPr0=;
 b=L6xMmvjtqEjutNRvvSbnxu3HBoUJ/kl3a4IUIYxHxEe5O1HPX4AtMUlDbjr08FxrWw3kR4OjmOfUFBKXJ3TYLprWUClx5+G4s4by/OUp/5HdeWlufFSeiNktSR+XI2zvZPlX0AIOn3oYocn5yq4jz6sI7d74NzscMnYyx5H1Nhaued3SRExRGN4UfVUNj0fBK8hx5ffO3Zp4+sJxT3m3f4zXmshQIcJ+3YgYCVV2NL2pRpIpGpbagNLU3KET998BPKBXxAttD8CLlNUYHJet6oW8XwOVDx4GmLZGoyBiy4krCb4ChMggjT6sx1/7un+1In/JtrUcRDZodm68LgpUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Azq+5820iPkYK3GsujyUq7ZhL5EfXe6T+SrawhZPr0=;
 b=cRSyX+0kcolEse4s43CBo4SSnmHNaluHvrNHGZ7Quk0MRI7zQRDFYnixrgDt6lBBpNrqw/GjvOW+JgUgMFkOWcV2i6mGh9lXW/TSgepxAUZNI5PUOH+JTe9dl436euSiifSJhYmYBi5Kay8xmRNFAKqVYDUqtxqNGaCT4zLYdrI=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by IA1PR21MB3472.namprd21.prod.outlook.com (2603:10b6:208:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Thu, 22 Jun
 2023 21:27:29 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Thu, 22 Jun 2023
 21:27:28 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZpSXHWClvPI8gjEKo8Uq7we4bGK+XVgJA
Date:   Thu, 22 Jun 2023 21:27:28 +0000
Message-ID: <PH7PR21MB311654255C0E401ECF6B1BC6CA22A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb1f6893-381b-46c4-93cb-026abf6b4dda;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-22T21:26:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|IA1PR21MB3472:EE_
x-ms-office365-filtering-correlation-id: a4924b45-759d-45a1-2379-08db73677ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrlBrVQayW9Gf2ZJI6mQe3tWGZniJVOSr/WaIEseaXM+g2jNe9PQBLF2qZlG3A3GSak7YS04taEHKTlOkK/GBV5pGxNvM635TBy1j2RSLgCz8FCo9rhElBtnVdT7DP3VJojdpfFkQSIPnXn8DGlVpNTDVXmynDAO0oOFynXQqneSxdEf2bNBLBhCyaUxRGKMaZO37E+o8UfHA3TRz+Z1XFXlwcVNtyylLStB0JUh+rD3OSdHHG35VGuLKNE1CpuQkzz8OVD3Mu4RRh0ILpSrWkt2KbWxoQN0e4tLYkDp9OZJX7c4JaibopYEhPKPmGpN3FCE3K6j6KFllNR+qh16O31yPOAhHnbhy1zzZgUCJsF5WTc02H0zEBJvbyLMwViazUAOExih1gmiPoMjpk+uGqAtkQorcrRrdEaHVBS47iQePQiijsK1gdg3wpQ/V5nDfhScnv0oc12CUxcenjwDImATv4rI5KHSRV1fcJmybF7+gLPFxOGGKClPktypGM9kFTZ03yNRB3fuEo0RKCa8NB6/vvaBtJ4BL1FXxFrksiOFNbkPvfEciJwkX/zbzdmw9+J7tuEO1425rnMaAXl8JxuUg3sxTkhvRcTQb9UY7ltN8z1FLVvmCKhmEJuvXfk9Hj619j73ndc5IfTSP5cJYaUJ5ETt+1/4hS9gVuiTX2uu4Dgg7wgPBYXVb6P3BabU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(38100700002)(82960400001)(82950400001)(921005)(122000001)(55016003)(38070700005)(33656002)(86362001)(71200400001)(53546011)(7696005)(186003)(26005)(6506007)(8936002)(8676002)(9686003)(52536014)(7416002)(8990500004)(478600001)(41300700001)(110136005)(4326008)(54906003)(10290500003)(5660300002)(316002)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nbVkLgZLWolbERgK8ZfZlOLARNIV4dhVSpzhZuZFb4XVnc1vvXh/trpzbNy6?=
 =?us-ascii?Q?y61zAN3X+7qnndXihwZMYMGiC7HLF5ZAlJdMUzDIrHXHsTQ9MIe2BABZCPdI?=
 =?us-ascii?Q?3tCrAkZP65kmfOjuJKJKy3RlGkMcqTWDGDBBNmossRWaYFUDh6pVskBPYOBi?=
 =?us-ascii?Q?j8AgVdpbIuT640RBd4hoz0LL76tpV/Oh0RjFvlhzNUoSxE4puRunxziqQTrM?=
 =?us-ascii?Q?Skp7Up7wqBnQ3IV2h8azqr1p5kMlOx27LInr2zMzvSON6eCqxQjTjTCGGU1D?=
 =?us-ascii?Q?pPjVyXk0+gX+61K5fPvVAe0kcX506ucM6jI8HnuMndP+6u7tc9Dd/tcZgKCF?=
 =?us-ascii?Q?dZp5CTbVyxWO20ieB/9cSHQE4ZqWT5h5p8MvaWV+AK3IZmFu3ME+awHdj2EV?=
 =?us-ascii?Q?B7iEg7UMBCfNPG80d4qncurSpw0EGki0iktEVoWcROGoc7HXFLxOvFXrgXKx?=
 =?us-ascii?Q?tR5BnZz2PpSiGGSGu6Nm7bQad0JVuiqlNmGoF9SCzBas4am3bwmj24waM5FE?=
 =?us-ascii?Q?GREnP0YoWM2/b10EhxbsrJyb4gpj4PCKBntglVroOPfZVCQSGMbHN5anOHan?=
 =?us-ascii?Q?cbi21wCoCGpnqLm1YsDLvg1MemhZ423A/q6+2n+yjDGTUFT9HBL6lsxc5Rzh?=
 =?us-ascii?Q?pqn467aqEmZSvuKQBDOvRaGsLhslIy3SCpzEiFlGernJ+oJBDiEjJsFG1JcC?=
 =?us-ascii?Q?T+otNy77MoNt4/78uwLHcZYjdZP6ffOQcLEv7qktx00MuNJg/QqA8vPq53Sh?=
 =?us-ascii?Q?J6fBUFi66B3DYreci4qyMX6YKgzgspef3gdsFXTKlghcY3o1q6ixNSaiXhi6?=
 =?us-ascii?Q?3Ld1MWx4o9CCB1dgeGmCaBUJxLRR7jP8kg34uXZC1cgUfmDA8fGNt6Evdtz2?=
 =?us-ascii?Q?83ZkVx+fjybTQeTYrYOyMlsjwFwRWjRWJYUgReJO0wiA9QM6XbWT3i522Qaz?=
 =?us-ascii?Q?YEnGaBv7Z68g9PyBOPpPEYF9R+cBCDf5YK8jp3Z5gY/FkCuo80wu+cB9POI2?=
 =?us-ascii?Q?kFRr+kMduHpJqpnQc1SZq4BLQirJhOi+OhdIIjs0qKr78Ip9hIc4tXJFZTOT?=
 =?us-ascii?Q?MCVdffGw1HBrmIKwa9qo66BT2UjS+h+gITXu8i1/g85Nlq3UBHjZ1+BAyNSx?=
 =?us-ascii?Q?2uhH/pDX7JiaWj/7djZ1WWVjVqxgKZNDi/Xk5ntj5Iv5ZZbKjIDGt7P+Gmmb?=
 =?us-ascii?Q?1qcMvyN+0hnhGYFS5qxRs1+1rvwn4Bzq5ZPJmC42mcbDPypzydXb+O6E8NcE?=
 =?us-ascii?Q?dJIpe57j7cmVc5d1M25i1N7PKoiB99SiSUfLRCOOngQ9LgQ+GeKN55FZPb9F?=
 =?us-ascii?Q?xUvFquM1pBm5NJ9E2EbO7uyep/xNXHaN4oug8lXd9LRGhpaUA0L8IGIuH00Y?=
 =?us-ascii?Q?qVQPkuRtAiRZvyDSnpKXoABu4k4gawvbtcIUtdmtppelh415ITyGRZTBOIGB?=
 =?us-ascii?Q?AinCyiDFqYSIhLkslVdgY9Zj7qJ992d53nPeyZ2NqccuzFOBsLquNI5S4OaT?=
 =?us-ascii?Q?fh+wLfCeh8pZ+dcUyPVbzN8+mPLNTcABuMyKeZoT1+0SqavTqJRRxccbwdgv?=
 =?us-ascii?Q?pY2HzwtK70ivCXwfdj8XFHw+O73TQPR3mWWe4jfg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4924b45-759d-45a1-2379-08db73677ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 21:27:28.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Wi43KkwQ/c/rY9ChjsxTtMTLgTtPJ2nPUPGaFVR2cuENH86+CNnMIUDpFe+IJLPJRcf7YZyCy6hGpviwc+ONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Thursday, June 22, 2023 12:23 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> Ajay Sharma <sharmaajay@microsoft.com>; Dexuan Cui
> <decui@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: linux-rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Long Li
> <longli@microsoft.com>; stable@vger.kernel.org
> Subject: [PATCH v2] net: mana: Batch ringing RX queue doorbell on receivi=
ng
> packets
>=20
> From: Long Li <longli@microsoft.com>
>=20
> It's inefficient to ring the doorbell page every time a WQE is posted to
> the received queue.
>=20
> Move the code for ringing doorbell page to where after we have posted all
> WQEs to the receive queue during a callback from napi_poll().
>=20
> Tests showed no regression in network latency benchmarks.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> Adapter (MANA)")
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
