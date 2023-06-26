Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0773EEDF
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jun 2023 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjFZWz6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 18:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFZWz4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 18:55:56 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020014.outbound.protection.outlook.com [52.101.61.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD53173D;
        Mon, 26 Jun 2023 15:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkC8R4oy+AZh7RqALcd7e6uZXNi/oyf83Ods06MB7kZ97uMcnQMF5JDoK+Tjd099OcbsfxURynBqDNfrC2GMH0Ec7NCvewQv3qdRdo2Ry3Z5grlqnb8yZSs2dCUFeehXYH66C2xT2S2j7Kwfmb1A1OFfX2+mhAy4fOS64uXaHUaL8e8oCgtElat2oaW8+j23X1p+9CyMFX3Sy6W8Y1+txLLaoiwax2Ae/cRdTLscdgPmnVd3qi6v6ozekz2+Co3HLQm5XqnKycPT1Qn0cBCSSMPYR/seTZ7ULsqR/CnWOTvrGXnpPJjSko7Bde5/Qgv2mWXk6NCWk4l3E2wFJvfq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqH/echpV71pjS0PK2O821QGsfLm8drA0wbv4GcI4Vw=;
 b=fAYs/TRm31lzNYolTlLJl9bHz0u6z9EhX+GOf+p/iU0adBeBc4XrpbB2NpEUmORKQkeo/yMQm/ZthLW+14yDDaSoLDsOHAAzEMARPHnjDyJbh1m6ZOTyUYW1GTCxEeiJnxC/UuEer0I9pNusehTWqo2st5QUKLxPkcrpCrWeKR52AA5j7ez2evUw5LGtpBVU2Xrhcw0Ug7SQnwhBNCbnsyiRGcTvD7EwyCdOzya1lYmTCDkyZJpSi3pAU6HnM3Vwlab5m3jbbDYUyvhRJNC8AcAIRYoCulVZfh7uv0s2e3K1dG2HirHWifciT2lEBXv8JnTngjATmR4FompO7SmPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqH/echpV71pjS0PK2O821QGsfLm8drA0wbv4GcI4Vw=;
 b=awVmZeihSlip1wyx4X04zogj/FN3QWJqGvBcqAh9r9PBwo7au2ppo+S/kgc4MpH3JS3giSjsRQ7JwfZq2eV4iXLyxsUwbtE+flDsXjb89BwT4SmPr5vdsCqHld18aWiwrbaSM6XyMnWXVDSzpg6pSl+lLZ0G+2tFztWsp076wtc=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by MW4PR21MB1858.namprd21.prod.outlook.com (2603:10b6:303:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Mon, 26 Jun
 2023 22:55:24 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Mon, 26 Jun 2023
 22:55:24 +0000
From:   Long Li <longli@microsoft.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZpSXIa1Vhnbd/CE6A5aEwx26oOa+ahxyAgAMw48A=
Date:   Mon, 26 Jun 2023 22:55:24 +0000
Message-ID: <PH7PR21MB3263595D72A3C2EC871D668CCE26A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687450956-6407-1-git-send-email-longli@linuxonhyperv.com>
 <20230624151037.699c50c6@kernel.org>
In-Reply-To: <20230624151037.699c50c6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41d9fe63-0fd2-4d6b-af80-291a65b38139;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T22:54:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|MW4PR21MB1858:EE_
x-ms-office365-filtering-correlation-id: 56311525-c5e4-4125-d480-08db76986d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3VBeObbGGQMGIxVzsaoJvOtw8F8LwCL6MwS+/ZID2wTzx7E4tvhPsXrPLQwvzSQ/6wyq00xsVrF11VmYYMImubavE/SRSgAO4Gn/eUOvEqTbu6vb6+FCDpN8z4cMZ3iJaGiWWvmV00WaBa0FjXPyR1Td0z+dkMRUCplFe6W4RH9YR8Enk7sNX0dD5FdONJGRNGj2qxK2lPaL4TsX0DOzHtx9vAZRPSUb3Up5+Q3/bJeEWvEcaooMGchx+7hwNLJ3ZqR845m3ELrD6scMxP7REl4lVf5a+35bTqfvnCMvYmK2UqmQiqT6DDOWVc8vNrlz4J5dkK+JBLmC7YV008qJ2oF5meD9cQyekH5e4Oe8w+zAEnjajfQO4QRjQRBe5dqW7eE+QSUPIGW4e+e89GyjxnNzgWr2CA+Zp7isNmPh9iuZFVZZ3fhcXsn2ov4tsrXDdcys0+QHK2wVRc+81hEV5Hiegnh9gc60/+or6Te7QwYHAJJIt4xlZXx/Qb87bGdz9gqOou70MtZGLjQYYJnwzQtNq5q83kdQg4CDlfoXD4i8s3wIPNQZxR1qgqZB++0TWBQSLmUkFUdxUI2mg+0mkA7Fw7j2zNHlsMY5Jh4rry71zUdC7tw1SqDgjYsc2lL8LVmio5A9BXTnM0f/sNMY00/sufdTKIgh+51PQO4VPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(38100700002)(7696005)(71200400001)(82960400001)(83380400001)(82950400001)(122000001)(186003)(9686003)(110136005)(41300700001)(54906003)(55016003)(8990500004)(38070700005)(86362001)(10290500003)(478600001)(316002)(2906002)(66476007)(4326008)(66446008)(66946007)(64756008)(66556008)(33656002)(76116006)(8936002)(8676002)(6506007)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QaMLcmEnhtvje2u4Q3w35U3c+Uo5gM1Qq3xH4F82e44WQs2hivsGPc45AEHr?=
 =?us-ascii?Q?qvnDxQ3UhQTZRwXq9rfMgU8paaDuF6x5qFV6w+cn9xHDpFAy1LD34glafIFP?=
 =?us-ascii?Q?dNpUzlxdZKQlxTou8xH8Ra/mV9Mr4I+uLzHcDWzX8xPtVmg06+fFz1WvUCbo?=
 =?us-ascii?Q?3RPmJ8qT15Owd9/mqHvTRwFKV46dnpG7DxErXVQDt+llwp1V9yiznfNighSq?=
 =?us-ascii?Q?xDVAGmzQlADbfgMX7+N45GMb+uYjyll8fI9ZKIVzHBpQVPVi4+QWys6qDeJq?=
 =?us-ascii?Q?4HNAg0e2sKfdbMInf4z4mb/cd3llNdO4BkHmUejqdhctJNEerSnKOiRRLPln?=
 =?us-ascii?Q?niSUlRX6jGY4aX5ndSnnCtG7brG3JfcBb+LZiVLavUNp8tDU8/RRYdgq0lyb?=
 =?us-ascii?Q?2YBrXO5oP+l8s6l6E5xGFFod+GyHwI/uwUhS4LBmUw/Oz5Y8/jLFuM7CK86P?=
 =?us-ascii?Q?j2/OT6PM3bU0xWQi5FxodJw24NyRRm8mF/wbiGp7zk6TEEOPJFuO42ddBypu?=
 =?us-ascii?Q?emseF5O6z2GCNVQCS9RrfgyLf7LCz5deln46xNj/hbxqwKZ8ASKdqxzWlk6R?=
 =?us-ascii?Q?537QHvZlMJDCXa7h/7rZZp2Nfkbs8cTrxE3L1DzNSJ4XGDfQ7pKZZOmddrAR?=
 =?us-ascii?Q?cISBatMPApVEXhY/3YAROeqEr2khkN6RQ58XYE6w7vVg6qXwf0OjsSPRok/z?=
 =?us-ascii?Q?E2AHc5jmqcP3AQFc5PpP/vNVeqr/dm7JApitg4rEAF99y818xtx0tyS31Kpn?=
 =?us-ascii?Q?5QKd+7bOKQ7MQNDVQrTW6GcfNmaKThvuocvHbZkl5hF1yH65l3jDmXNqbEDX?=
 =?us-ascii?Q?oFHSlyVIPKh1Yt+XLfQZ7dUNQyiWQrrLVntov3zDqbkXE51o/O8iVh3O/4iB?=
 =?us-ascii?Q?u29Ij64IAGWWu6aJcOXeYe/li0+rWZiUVeqOtk5/NrADw0tIkoiXC2CCVdyI?=
 =?us-ascii?Q?NlryuOU7bY5aivV2LzkY8V9Ve4k+oP1D9TmQix5BgCUoeBn5t8KUcnwYA88U?=
 =?us-ascii?Q?KF8St919k1ZYvCEVe25Cs/PE1LQ0jYjKm6k6Q1nr4lJYl9Ox6wiTIn8YiYZ3?=
 =?us-ascii?Q?yQc7H8f0Qm4+jhrFUuOdoJFj5AK+TT6ksRu7QJVDd8EAzwctWxWn5e0nLIPu?=
 =?us-ascii?Q?xeQhqbuK+/uZ6MzwKqNTVi3PhPk8xlWI2XMSku4W9Q67SJxebJxb+1hCphbz?=
 =?us-ascii?Q?7xRAIwubzHxLOuuyj4IbyT4eTZT/fQtY51+2ckNG+GhzESIMlIhqWQtMqYoJ?=
 =?us-ascii?Q?iFI+bmfYQg5Cbmwv6VRGZuMexxASusUubeZ+50++5/9Yk2vjK2bHz8omPF7U?=
 =?us-ascii?Q?9LZs2oBX8lTyVO6tYltvMTpocxoMkEGNhwB6Ww+UfWLSEFY2ylVVuwprNRNM?=
 =?us-ascii?Q?rBu5L9mt8jrq6KfikR3XgoyiJnPPsxOeTSvnIGw1n/MJEo1yBpIp5LbVFO+M?=
 =?us-ascii?Q?Sa/ib6u9KcK/VsZbhzhlqNfUDWfRNPwOZfHDUrPZ6PwbaPfoxZJwMHoOtBBU?=
 =?us-ascii?Q?WRjN3YB1+C3M18l2tTQZpiWvoEVW90W4J/POHHyAycLt0YzJ8rmCZ8Tv4Ap2?=
 =?us-ascii?Q?dHJfHIB8aRikCFDevUVXCdII7AC+/bLeOaWlzbwh47Q4hE9uvW1Dms+eUjhS?=
 =?us-ascii?Q?uD9B8BKF1rTgGljvx0xQv3xSUd7KW/brc+hdi34/bDkE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56311525-c5e4-4125-d480-08db76986d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 22:55:24.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtgsHxvPnIStHFAiIQh/NLywLruIzEwVqMGLA7WQAjAAAfafEKyXeXtx9uvuKn0TBNs4Bw/3xYn4AFQzSzh6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH v2] net: mana: Batch ringing RX queue doorbell on
> receiving packets
>=20
> On Thu, 22 Jun 2023 09:22:36 -0700 longli@linuxonhyperv.com wrote:
> > It's inefficient to ring the doorbell page every time a WQE is posted
> > to the received queue.
> >
> > Move the code for ringing doorbell page to where after we have posted
> > all WQEs to the receive queue during a callback from napi_poll().
> >
> > Tests showed no regression in network latency benchmarks.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure
> > Network Adapter (MANA)")
>=20
> If this is supposed to be a fix, you need to clearly explain what the
> performance loss was, so that backporters can make an informed decision.

I'm sending v3 to include the details.

>=20
> >  drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
> >  drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 8f3f78b68592..ef11d09a3655 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -300,8 +300,11 @@ static void mana_gd_ring_doorbell(struct
> > gdma_context *gc, u32 db_index,
> >
> >  void mana_gd_wq_ring_doorbell(struct gdma_context *gc, struct
> > gdma_queue *queue)  {
> > +	/* BNIC Spec specifies that client should set 0 for rq.wqe_cnt
> > +	 * This value is not used in sq
> > +	 */
> >  	mana_gd_ring_doorbell(gc, queue->gdma_dev->doorbell, queue-
> >type,
> > -			      queue->id, queue->head * GDMA_WQE_BU_SIZE,
> 1);
> > +			      queue->id, queue->head * GDMA_WQE_BU_SIZE,
> 0);
> >  }
>=20
> This change needs to be explained in the commit message, or should be a
> separate patch.

Will explain the change in the commit message.

Thanks,
Long

> --
> pw-bot: cr
