Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1373E374
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFZPfj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFZPf3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 11:35:29 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CD10DC;
        Mon, 26 Jun 2023 08:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpYJr5ut5VAdBUs0bqCO7adlSgeOSIJDoFFbZia6nz4ANtPqwAnhKZRCo98DC/0AV7ODDlxtc3IuKasnTr7WeLpRhYTTale/SM05Lfl3hIDHJumluhc8JpLEclwOUH98lUxSlbuh0wdZ2TsykmTUg4l/xKocRvZtoHoqAvnws2y6H+3814JuVPNr9jy7ULkCdi9eqAKg5dPxfPHnkUDj1oSRtP94O1Gk6jwylGQEJ6niMvHTdXEV8DhrXh95iL6MAUgWadTXB9NIDZnyS9pT8nJdAKrKOqqXRfIvlqiXSHlrXuYHKefOzTgZYXX7gqSNivaaSWUBT5BvAM333+tAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA6ZbdtABmklBjz1eIO6dJGoKErWzeodjUTh5BMZqqw=;
 b=WYYNBceJII/blt5TiDVLAqc2YLvnA0y7X39oX2r9ZN07/AWtG92NOL7K3tt9f42non43yNZku7shD4CbvBuIrM1TJDiJDwvDsKte7Oc5o2fiwv5Buj9ppAiEMbZ3HK9r3n3Mx9BIGuuWf/fwHym4JtDOZbEP4Gzsho0MB/Y6xdsC+Q+Kr5xE6ByHyu7nYhuOcMAmd6y0xuLxTWYNOxssLRXNZIgtPALg4PMKB6tmUw24cNm7yoWN6FH07PA4MsPSq5uXBkLgWR+ZIIRr0v8Rcux82rfNReJ9NVbQu6yU9lmUL6aQZwrnNY1uwSu1wNuKsmjdRf16HRANLq2C4tKkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA6ZbdtABmklBjz1eIO6dJGoKErWzeodjUTh5BMZqqw=;
 b=ZDC1ydlmOTFl6Hm/Rtp0LaShltOBZK8bvX+S0ygsvBUWrB8ZQs0PgXpGPXso2ema6lohYSNKVUNsyyieC30E8cXBgrWB/5HWyvlFIVEmGDeUGGYU51Kw+a+2FSAwRGnoNsRrcNoIFnZ7XF0RfVZ2fTdG418orUeOANuwOIp6WV0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3562.namprd21.prod.outlook.com (2603:10b6:8:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.3; Mon, 26 Jun
 2023 15:35:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6565.001; Mon, 26 Jun 2023
 15:35:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Topic: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Index: AQHZqA+YFwPfLlDliEeE2fWQPWksHq+czliAgABmD6A=
Date:   Mon, 26 Jun 2023 15:35:22 +0000
Message-ID: <BYAPR21MB1688B43152773B7989353A5ED726A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771137-26911-1-git-send-email-schakrabarti@linux.microsoft.com>
In-Reply-To: <1687771137-26911-1-git-send-email-schakrabarti@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afc6ead2-25d0-4c9b-b92e-5e8523239d00;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T15:24:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3562:EE_
x-ms-office365-filtering-correlation-id: d23a0200-515a-460b-b248-08db765af4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cu1kovn0hFVa4hmjGjHpxrdhWm2mNLkarIZjOssRwIs25wr2iNsSwvw7wShcr5JGsZDXWkz32HUZmoWlaCwHz8dDmke9NJtvml8Ea36u2ZbdytwqtRsghIeT/nqQuPod09zP1cyBlqjvGinbSbTvBUoBjJeOf3FAqUOm/KudtBxj+U8zThktmr446a33viKoo7uGNbAc3XzUs/LEPMihbiDEvRTPmcJmin0N//6WgczdGoSdOg+J7JB7HQ4btQ026Ve5fRfmXjvL1l9XlqLFGddznRItwAlnxaQ1IjTP4QhkOI8j/P8k0TJtbxlp1/iCN16SDsGeqHgeSq9cIDhd1KxUxgCk2TNSSm1hXmHKPYI1KX+O/zr5bZL6iInI4wWMqsYhIo4nV+Nwy4XlE+PElHFmKxiGwitXkHEDISKZEwWskloZkyqO+X+vjYEOQ+UXNq6xWy4Ttfdt/hUpk08w3sYnOUeLOPLyCnjIOnEJGCxvDMC+SbO3abq/6S6Y+tipgn1lDvIOOI5rNF0JP/wneKsME7u5U1JFnaddBrZL3vPyEszMs25cuA9+10ccmAVCU6ek+e5c8RUyUvWG2zX61E01IaZdR1w2ppd8bQI5KBqg+LegHd4Di+FdWGS1cmCr8sj1ikc2wPKXjLAEy9kXGjkbyjEr7IZBhutLbNAkV8uTYwCT/IakVfUylkKsX4m/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(26005)(4326008)(33656002)(8676002)(8936002)(66946007)(66446008)(316002)(66556008)(64756008)(66476007)(76116006)(5660300002)(52536014)(66899021)(7416002)(10290500003)(478600001)(38070700005)(2906002)(55016003)(86362001)(8990500004)(54906003)(41300700001)(82950400001)(7696005)(186003)(6506007)(9686003)(82960400001)(83380400001)(110136005)(107886003)(38100700002)(921005)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n1R0gWFzDwIjm4bzJe/mF3/WcVWobDaq3AotLfhjxXGufxZHbNBv27Tb+ERy?=
 =?us-ascii?Q?lCyjHxDoHJP1S8Kkyih1lsD+EXvyD2Up+6sOv4wOan/WdCEywueC+6N5NwNP?=
 =?us-ascii?Q?RqmM64n2bHkmGFBji4zR8Uw+/m/HDAVkPebHrnLVKgxIh+HcyQUwVPI48gBl?=
 =?us-ascii?Q?+aTAayBIlI6VE73BClLz/SP79LC1wcgOadoA6gmFvmsw6blBgDoVwCW01K2M?=
 =?us-ascii?Q?Z1dQWuGpf5O6hrb5Eid/quab2btviIqUDx6+pohMjb2theQ8MvrkwoQhqcRS?=
 =?us-ascii?Q?1cw7VRs44WHeLr+tskH91VJ9Cmvxh01kDDNkalnjygx312fdyJoKAid40neF?=
 =?us-ascii?Q?J3KbDEEQVGpA8V261tweI3bIlrmQ17w5u+qVh3OcPoaZDPhyGuES2yQZ2Zwh?=
 =?us-ascii?Q?5RL6CsSLSLiO8X9ebOKGtAM8Q6k/aj//qkk18j3q5o8dHHRzGDkVh+4/IOL1?=
 =?us-ascii?Q?1HAKCIfDxFC6a8Y8oArdqkNT2b4ZtdRKviK2tHtgwPyaA2gNAkvCrvKJj1gw?=
 =?us-ascii?Q?m32dPe9sfbhAJ1pjrO8ncOvJRokjx/JrGBskkZB3W8hCwoWIqjyDJuN5Pu7r?=
 =?us-ascii?Q?2S2L3Ay9Ubew4Yvv0JI08TysM0YL86qLgSA5DSiJ1taqyo6m8HCZ5fwXB0oa?=
 =?us-ascii?Q?YA+ERcbTour1HhSbBeWGSP3thTjw9XHGlwNf2xqBBCG7l+22uHdGA0ZEW8l2?=
 =?us-ascii?Q?HQEC19ObFjsoH/g2qLipC3xovRx45k/d+xagxLLQPLb7OuqwlKA90yqQrIbL?=
 =?us-ascii?Q?T+F0U4f6190Z4Qvs2GVTuSPsNu3UQVB1IQkVKangLI3y8XmXxzuBjsJo2Adb?=
 =?us-ascii?Q?jsS9fF6RaNKnPPsOrASNgtRqKt//6TtAQO7U0PzzQYzqc4mVKa8Akenu8E8J?=
 =?us-ascii?Q?8yStzpqkIOcWvUl/aDpO7/Ylu/v5+bi2lFD9L272DQ/WiHG+9OVkJrlq5rNZ?=
 =?us-ascii?Q?NPFT0vRgeSZ9tmFs3MS4ovMa7JXTQgE7smvqVgEegVCAelbYQhhY0TL9M9kV?=
 =?us-ascii?Q?WaXaB+g6hEvAt52m2yT3Ah9v38BlFMcLZUgFH3uXO6tOSCfVip1ciquIZq5d?=
 =?us-ascii?Q?b7NabPQbrkzwCywWx8DVe3dBSYcC1qfMw6oC3dJ/ChLh6ncLiz30ujzab2zL?=
 =?us-ascii?Q?XpkyXo77Ld+XuOtwvyzy5b2EvM1CmcY9laZrIYTlPCzwABln+R+MXBj5Sg7h?=
 =?us-ascii?Q?SuaPIVl990d7GQOhNkBI4TVnxuwkvWKRaJW8k5orYV9x1PvRW37ggeyj1Bnc?=
 =?us-ascii?Q?Yb4ZFGyv7Gv52ylGYX4rwGMr67SX2gsLu2s5Uci2tliKBFEUdSeyD7sDWUO/?=
 =?us-ascii?Q?0B4ojUVD54ezTK8eTp64d1FSkE6Ks5Wx7S97aNaSFh7ekCOPBqQSPO0dvWel?=
 =?us-ascii?Q?n44cxozUj9gENKSE8ff+bmKK9GtRZVOihtEy0hXTC/MN92AfpONjjfA8OKVe?=
 =?us-ascii?Q?U1aQZ8OUojzCt7kUeCc+5LInv9iTZhBGm7JkeZSp9YZKoQheXmZZS7AmponN?=
 =?us-ascii?Q?vdJjC6wtENg/BidpcrhqlMCQXyW4qZzBbfSrjxKLD4OaocwklRzyZuN9Di7R?=
 =?us-ascii?Q?tQMMdSD1R0Ndepu3GJ8Cvv/gX0MaKRHAmSNNgWvpXq5aIPVUrFiUVLLx7Qkr?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a0200-515a-460b-b248-08db765af4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:35:22.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dr4cUyw5pTMOyZFF9SsBf9Zy++rp0zvCH34a0V0hGW9RpFJwiZSE46yysgSomqC2x67f11hDXOc7DiOSDL0jOOETf9tg+7M3czfjeyftNgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: souradeep chakrabarti <schakrabarti@linux.microsoft.com> Sent: Monday=
, June 26, 2023 2:19 AM
>=20
> This patch addresses the VF unload issue, where mana_dealloc_queues()
> gets stuck in infinite while loop, because of host unresponsiveness.
> It adds a timeout in the while loop, to fix it.

For a patch series, the cover letter (patch 0 of the series) does not get
included in the commit log anywhere.   The cover letter can provide
overall motivation and describe how the patches fit together, but the
commit message for each patch should be as self-contained as possible.

The commit message here refers to "the VF unload issue", and there's
no context for understanding what that issue is, though you do provide
some description in the text following "where". Could you provide a
commit message that is a bit more self-contained?

Same comment applies to commit message for the 2nd patch of this
series.

Also, avoid text like "this patch".   See the "Describe your changes"
section in Documentation/process/submitting-patches.rst where the
use of imperative mood is mentioned.  If you like, I can provide some
offline help on writing a good commit message.

Michael

>=20
> Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a driver =
for
> Microsoft Azure Network Adapter)
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
> V2 -> V3:
> * Splitted the patch in two parts.
> * Removed the unnecessary braces from mana_dealloc_queues().
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d907727c7b7a..cb5c43c3c47e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2329,7 +2329,10 @@ static int mana_dealloc_queues(struct net_device *=
ndev)
>  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
>  	struct gdma_dev *gd =3D apc->ac->gdma_dev;
> +	unsigned long timeout;
>  	struct mana_txq *txq;
> +	struct sk_buff *skb;
> +	struct mana_cq *cq;
>  	int i, err;
>=20
>  	if (apc->port_is_up)
> @@ -2348,13 +2351,25 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>  	 *
>  	 * Drain all the in-flight TX packets
>  	 */
> +
> +	timeout =3D jiffies + 120 * HZ;
>  	for (i =3D 0; i < apc->num_queues; i++) {
>  		txq =3D &apc->tx_qp[i].txq;
> -
> -		while (atomic_read(&txq->pending_sends) > 0)
> +		while (atomic_read(&txq->pending_sends) > 0 &&
> +		       time_before(jiffies, timeout))
>  			usleep_range(1000, 2000);
>  	}
>=20
> +	for (i =3D 0; i < apc->num_queues; i++) {
> +		txq =3D &apc->tx_qp[i].txq;
> +		cq =3D &apc->tx_qp[i].tx_cq;
> +		while (atomic_read(&txq->pending_sends)) {
> +			skb =3D skb_dequeue(&txq->pending_skbs);
> +			mana_unmap_skb(skb, apc);
> +			napi_consume_skb(skb, cq->budget);
> +			atomic_sub(1, &txq->pending_sends);
> +		}
> +	}
>  	/* We're 100% sure the queues can no longer be woken up, because
>  	 * we're sure now mana_poll_tx_cq() can't be running.
>  	 */
> --
> 2.34.1

