Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C14EE24E
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Mar 2022 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbiCaUGd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 31 Mar 2022 16:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiCaUGc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 31 Mar 2022 16:06:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CB18FAD1;
        Thu, 31 Mar 2022 13:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8CMr5bRxS3lBHNIg0XnxyBqA6gAVZ07DrnxNIhVArBEYLm9BFytJd7hCvBIdvOF4/ECTvcmo3Fub0WYOoKpRpDAeqnL9jiQ7XXgVYhN4fl9JEmOaJCFS/Bw0O6qxkYzjYLSdcefU4aYUIL32wtrGhiMrTdzDrHO5TPqlRvlI/di9kNGrLGEHn7qh3F2NI6CfyGdy4Qa4ecPNOni8L7FBH6nm1uNVZA37oQiVhp36L1WMd8EcepexvqaT400jcd3SEnfaUeapHdj4RIOCKDq2pLfsDxkped7A0Dt4ijrkbsVlWewBJ4r3lc7NHrHh/da0+riMtLmUw0NpjKtdeA0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSfiyWnkNnTt0zRCVRZyQus/1+vLSCKk2RrZUUY54OQ=;
 b=EOXexepcMUlv7W1evFSWyxr1SToERJfQVW2bdeX8tAvrJSmorcQCGtuWTCjjlqFM2g7HZn0klJ6IOLUzAvziVbakh6ikk2gclwgGe0NK8uEShTHRxd6jL663WMexJEn/gVP+OpB5Qx0mAkpBqRmPDN+mA4xjQUuQXPq1yhlCICzuAvn6o8SvYaVJOaj/cdfuxIJuLwPDr1sM5D73/NmMCKgFfitbeXzH/I0CkgEzDIxkkpsk/9NUlukhlVVnKiIe7ioHwCVnSLScKJeeX/Xtf+CoFB56ZvDlw37w4pvZ7THYYa+8KcKoBrrSZnvDikTMJGK9WZXM8KCQfbb06lHbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSfiyWnkNnTt0zRCVRZyQus/1+vLSCKk2RrZUUY54OQ=;
 b=PUua1oCSpkS63FfrJLMnQckBG48HbH1Au2OxBkhaWc1S4kof3yctgGCrnbnBLeFnQ7KJolxZiIdS4VumLMzLbT0XSbmZTL9g65KxaVIxVCYmuYZMdDmdxXgqN/si0PKZrIdIk/ZeIGAJonLr/6Y6dLjPmx+uQy20W+LWscWKM74=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MW4PR21MB1954.namprd21.prod.outlook.com (2603:10b6:303:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 20:04:40 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22%5]) with mapi id 15.20.5144.011; Thu, 31 Mar 2022
 20:04:40 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 4/4] PCI: hv: Fix synchronization between channel
 callback and hv_compose_msi_msg()
Thread-Topic: [RFC PATCH 4/4] PCI: hv: Fix synchronization between channel
 callback and hv_compose_msi_msg()
Thread-Index: AQHYQrIrpTQ6MYpPrkWe6EvPnUGST6zZ7BHw
Date:   Thu, 31 Mar 2022 20:04:40 +0000
Message-ID: <PH0PR21MB302522DE89BB5A0F59B1C29AD7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-5-parri.andrea@gmail.com>
In-Reply-To: <20220328144244.100228-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d67715b-9df6-4af7-9179-72b17aa4ec7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-31T19:51:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26b8a88f-69b8-4dbc-7c88-08da1351b0a4
x-ms-traffictypediagnostic: MW4PR21MB1954:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW4PR21MB1954BE6F5F5024982FE5AC57D7E19@MW4PR21MB1954.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+A39dRSIt1C91YbpSlv1A1/g4kIq316lg0xon8SkFD4KyLzwKC4c/SIgVALbOMriyYoOfgzxuHd5PXmbxjnZ8dLAunEjW0lJ+viijmz3PM7b2rSXMhS67pcr0Tq9Pok0y1+Ue0iN2XTT9uwkEq8SxXDThzS07u4aI76G+z6qUT1MzUukCf3e5wL/dBcWYHQACjKYVXTVpHV1SJdgEB3rU5hsWJLiYWgNae1+1GbWxptn3C4UkkRqATQAgmTDo7j7HleEwh4vwMdcJKv+4o27PYR9IF+OMLBlgo2/Y+s5o28sqUydFE0b2yGe74qVGEQN9BPOcamN4wNMICrUGc9lWqsBcuNCox9+FMnDozat6+h9VRebgjMXenihZaRJszgrwxKG0qGivY9QfLq/QmmabtXLTo4ijkIHkpypMkulZNrgJC7UxcCUwYyVERW8rlpeWCYfChpfC7Cg3TcNoYjZZIsTo34OioYZIxi8SnCsWmAD3WWFrg393OYPsP49jGA+rsUXzmP2f6J1Sue7G3KhhueYMK5f1Q4YI1vH/YPMFaYluy9wIc6X/ix+HIfc8pnOWIiB2obXO+/+1kiopyMTsfPE0ScXnlM7XMKRXL8MCwPqHt3hAWHKRF4YycC9bshWLIMTpuB32QEBitaQCU98gDSY/LK2wPfR6J0RQhcwQfJLCg6LLyDRbkbZ/HNKIEzvcJg8BrQg51TJivNxU7EtHEo3PJnzAWeIeS8rtj9a3uG5d8HS7SCKhWAsJt0Q4gvTWqaSajW6bFpTggwPYoM5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(26005)(186003)(8936002)(38100700002)(38070700005)(6506007)(316002)(110136005)(7696005)(86362001)(9686003)(2906002)(54906003)(10290500003)(508600001)(8676002)(55016003)(52536014)(122000001)(33656002)(76116006)(8990500004)(66946007)(66556008)(82950400001)(66446008)(64756008)(66476007)(4326008)(5660300002)(921005)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?srYO5P/ZT1J4xUEIjpdLCkVJj0aprdG4BOOGBfptSIwkpt3AB8gJaTs9NE3a?=
 =?us-ascii?Q?0MC9Kdye8godft75c0mXzWTMN2f3xznd7oe/v617ok5b3pMYK69AfTN1q6Kn?=
 =?us-ascii?Q?HRdfOuWqF8CPNmJ8vBL1ekodGInkik6HhZJc/jZZS6wbhzZa2FizIBX/M7Wz?=
 =?us-ascii?Q?T+9ShwRBqg1pFwswcCo2Trzz107H2xO4EI2imTWsF8V8/qx4bOlW8Z1V9lQS?=
 =?us-ascii?Q?yobmlkeDfrF/pNI4ksSkxQpfinvqNZTpaKunRA/Ikm349KN5XkoPK9DFv7kK?=
 =?us-ascii?Q?zMQzm/D0s6MKrAZ//NirEd7mEedAVd47J+PMmLOsnG1jB1qNMdLO/9669KAI?=
 =?us-ascii?Q?s4fGYoBw28CCnScXKMyu8F3V3dvniczz67/K3Ml9maAlkiJPM+e/pL5jWvUF?=
 =?us-ascii?Q?7ijaMa/+9Vg1NhzLDeKLRL0GwHucKWwBuLSvXIMGzYR0g1tiYffB6+iIOkv2?=
 =?us-ascii?Q?ICIlFzx15yxq8mmlWzBp1ObTlsUpm8zVmh9vK4et7w6UINTAVcF5rHVzuP+V?=
 =?us-ascii?Q?2PykAu66QSkJ9uF8VM0WnrtOoC+CKnzfO3r/JvqP6LePKFKpKuAhzhaGmWAD?=
 =?us-ascii?Q?UTr8wqjV/cYwIqGhWWj8iY0wGCad0ITxVTYw2sFP5zWAglL+FuQGPOYBOoqh?=
 =?us-ascii?Q?GljL474BlSye9zqzra+PwmqOqv/Ij/hAcWISgD9IA0UJr4obFmVqr9mNJW/M?=
 =?us-ascii?Q?W4g/x4/MPaCL8KZQ+XLWofvK9AX7yRCrjJLej6napic1gkgzM0K3pmEsaAZ4?=
 =?us-ascii?Q?uvO0+IlTHrx8fc/2Jac0akAcDvUG7Adfsx3cQpIDQnvJ5Gu4o19ifFhTGw4x?=
 =?us-ascii?Q?OwDadgxi5vI+8Q2IUoAf1wA0HEB/Kkgkt+xyEyT+wdbT6PSxBXcShTV3+sIq?=
 =?us-ascii?Q?2V4Y7g5w6MAticjuGF8Ob9xTjZEy84EW9/ae+Yi3eBgDDKCg9fO4ln3F0fHA?=
 =?us-ascii?Q?YSrfrNbNyb6XqCOLQmrFcLvD647Bqa4WlgHwCx3wP2KPg99BSQKeclNCslUx?=
 =?us-ascii?Q?f52yrJROovL+L7J+eWE3+yePhLnnvcipNQ3V0FNhF0wiWqhDPd+uFx4gFZKf?=
 =?us-ascii?Q?+5qmGQeXpsJc+lDR9IL36drs0GAzAwK3Q5iliaxhFpv+E+TUQOCD6nTmcv/1?=
 =?us-ascii?Q?0a5ifpsz7fuAAt9vr7FM7kIXIwCOhsYrHPRy0Hyj//BMuoXLKZvRUX3RIjrq?=
 =?us-ascii?Q?vE4HEAix6xFSOT1TDGBg+rwZqGJztU4g8XkSwcQWcRE/Dappkuk55MpYwpeY?=
 =?us-ascii?Q?vtcuLgK7Iv+YHYuUf8Kn0nWoBjopTBWpqQuhCJl/HC9BsanGG5HUZ25vD0Cx?=
 =?us-ascii?Q?59iQ5/YP0zHavtN5fFkBi1ooJQziArN5DQgPNaDGBb0r6Tdx7MZ2BklT0b8u?=
 =?us-ascii?Q?pMxEJhKtn0cRU5oyRdreAunhvZNNa07v+qPL14lenBQTEiRcOtCbAy4YMPGO?=
 =?us-ascii?Q?/zorFn5Xt7ucrXQx7QmXdea202+bySjQwdwzocZ+XB1FH3ZlnR04mJ4acHmt?=
 =?us-ascii?Q?o8XC6vAOnr0xY3eMYs0z7v6rGQRF6sWUXrAhg67GEREUV9NbtKmnxOCTr0db?=
 =?us-ascii?Q?X5ZA30osj9uMHjLQMccvddphRhIwjxxfA94Up0cGD9o2sI9rx3d7GwRyaaQ1?=
 =?us-ascii?Q?Qytd9sRZUqnkTUVuIcQg9OnTOHOBLlexc2C9346aYuPSGhcE9sRG3sRdCmE8?=
 =?us-ascii?Q?2tJe02PJ77WY9upPgXpR4glh49OAaZK3z3fvIJkyYN7HD/OlRZXK+5apF5s7?=
 =?us-ascii?Q?dKcwRamAH/7FIuD4cuFvYQbPnlz0xIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b8a88f-69b8-4dbc-7c88-08da1351b0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 20:04:40.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZO3ncNd0AMmVDrPYuniO7BqMN4QNoPxoSriMX0zvmcKrtvdFGQEDhsusAf/0xLxltWI8UelK3cRyEbsxlHp5tKSFlO4CzdOuGJkSFbyg2KM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, March=
 28, 2022 7:43 AM
>=20
> Dexuan wrote:
>=20
>   "[...]  when we disable AccelNet, the host PCI VSP driver sends a
>    PCI_EJECT message first, and the channel callback may set
>    hpdev->state to hv_pcichild_ejecting on a different CPU.  This can
>    cause hv_compose_msi_msg() to exit from the loop and 'return', and
>    the on-stack variable 'ctxt' is invalid.  Now, if the response
>    message from the host arrives, the channel callback will try to
>    access the invalid 'ctxt' variable, and this may cause a crash."
>=20
> Schematically:
>=20
>   Hyper-V sends PCI_EJECT msg
>     hv_pci_onchannelcallback()
>       state =3D hv_pcichild_ejecting
>                                        hv_compose_msi_msg()
>                                          alloc and init comp_pkt
>                                          state =3D=3D hv_pcichild_ejectin=
g
>   Hyper-V sends VM_PKT_COMP msg
>     hv_pci_onchannelcallback()
>       retrieve address of comp_pkt
>                                          'free' comp_pkt and return
>       comp_pkt->completion_func()
>=20
> Dexuan also showed how the crash can be triggered after introducing
> suitable delays in the driver code, thus validating the 'assumption'
> that the host can still normally respond to the guest's compose_msi
> request after the host has started to eject the PCI device.
>=20
> Fix the synchronization by leveraging the requestor lock as follows:
>=20
>   - Before 'return'-ing in hv_compose_msi_msg(), remove the ID (while
>     holding the requestor lock) associated to the completion packet.
>=20
>   - Retrieve the address *and call ->completion_func() within a same
>     (requestor) critical section in hv_pci_onchannelcallback().
>=20
> Fixes: de0aa7b2f97d3 ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()=
")
> Reported-by: Wei Hu <weh@microsoft.com>
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 83 ++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 9f963a46b8298..8876b318173f0 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1662,6 +1662,55 @@ static u32 hv_compose_msi_req_v3(
>  	return sizeof(*int_pkt);
>  }
>=20
> +/* As in vmbus_request_addr() but without the requestor lock */
> +static u64 __hv_pci_request_addr(struct vmbus_channel *channel, u64 tran=
s_id)
> +{
> +	struct vmbus_requestor *rqstor =3D &channel->requestor;
> +	u64 req_addr;
> +
> +	if (trans_id >=3D rqstor->size ||
> +	    !test_bit(trans_id, rqstor->req_bitmap))
> +		return VMBUS_RQST_ERROR;
> +
> +	req_addr =3D rqstor->req_arr[trans_id];
> +	rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> +	rqstor->next_request_id =3D trans_id;
> +
> +	bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> +
> +	return req_addr;
> +}
> +
> +/*
> + * Clear/remove @trans_id from @channel's requestor, provided the memory
> + * address stored at @trans_id equals @rqst_addr.
> + */
> +static void hv_pci_request_addr_match(struct vmbus_channel *channel,
> +				      u64 trans_id, u64 rqst_addr)
> +{
> +	struct vmbus_requestor *rqstor =3D &channel->requestor;
> +	unsigned long flags;
> +	u64 req_addr;
> +
> +	spin_lock_irqsave(&rqstor->req_lock, flags);
> +
> +	if (trans_id >=3D rqstor->size ||
> +	    !test_bit(trans_id, rqstor->req_bitmap)) {
> +		spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +		return;
> +	}
> +
> +	req_addr =3D rqstor->req_arr[trans_id];
> +	if (req_addr =3D=3D rqst_addr) {
> +		rqstor->req_arr[trans_id] =3D rqstor->next_request_id;
> +		rqstor->next_request_id =3D trans_id;
> +
> +		bitmap_clear(rqstor->req_bitmap, trans_id, 1);
> +	}
> +
> +	spin_unlock_irqrestore(&rqstor->req_lock, flags);
> +}
> +

Even though these two new functions are used only in the Hyper-V
vPCI driver, it seems like they should go in drivers/hv/channel.c
along with vmbus_next_request_id() and vmbus_request_addr().
And maybe vmbus_request_addr(), which gets the spin lock,
could be implemented to call the new version above that
assumes the spin lock is already held.  Also, the new function
that requires matching on the rqst_addr might also be folded
into common code via an optional rqst_addr argument.

>  /**
>   * hv_compose_msi_msg() - Supplies a valid MSI address/data
>   * @data:	Everything about this MSI
> @@ -1691,7 +1740,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
a,
> struct msi_msg *msg)
>  			struct pci_create_interrupt3 v3;
>  		} int_pkts;
>  	} __packed ctxt;
> -
> +	u64 trans_id;
>  	u32 size;
>  	int ret;
>=20
> @@ -1753,10 +1802,10 @@ static void hv_compose_msi_msg(struct irq_data *d=
ata,
> struct msi_msg *msg)
>  		goto free_int_desc;
>  	}
>=20
> -	ret =3D vmbus_sendpacket(hpdev->hbus->hdev->channel, &ctxt.int_pkts,
> -			       size, (unsigned long)&ctxt.pci_pkt,
> -			       VM_PKT_DATA_INBAND,
> -			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	ret =3D vmbus_sendpacket_getid(hpdev->hbus->hdev->channel, &ctxt.int_pk=
ts,
> +				     size, (unsigned long)&ctxt.pci_pkt,
> +				     &trans_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret) {
>  		dev_err(&hbus->hdev->device,
>  			"Sending request for interrupt failed: 0x%x",
> @@ -1835,6 +1884,16 @@ static void hv_compose_msi_msg(struct irq_data *da=
ta,
> struct msi_msg *msg)
>=20
>  enable_tasklet:
>  	tasklet_enable(&channel->callback_event);
> +	/*
> +	 * The completion packet on the stack becomes invalid after 'return';
> +	 * remove the ID from the VMbus requestor if the identifier is still
> +	 * mapped to/associated with the packet.  (The identifier could have
> +	 * been 're-used', i.e., already removed and (re-)mapped.)
> +	 *
> +	 * Cf. hv_pci_onchannelcallback().
> +	 */
> +	hv_pci_request_addr_match(channel, trans_id,
> +				  (unsigned long)&ctxt.pci_pkt);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2700,6 +2759,8 @@ static void hv_pci_onchannelcallback(void *context)
>  	int ret;
>  	struct hv_pcibus_device *hbus =3D context;
>  	struct vmbus_channel *chan =3D hbus->hdev->channel;
> +	struct vmbus_requestor *rqstor =3D &chan->requestor;
> +	unsigned long flags;
>  	u32 bytes_recvd;
>  	u64 req_id, req_addr;
>  	struct vmpacket_descriptor *desc;
> @@ -2747,17 +2808,27 @@ static void hv_pci_onchannelcallback(void *contex=
t)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			req_addr =3D chan->request_addr_callback(chan, req_id);
> +			spin_lock_irqsave(&rqstor->req_lock, flags);

Obtaining the lock (and releasing it below) might be better abstracted into
a lock_requestor() and unlock_requestor() pair that are implemented in
drivers/hv/channel.c along with the other related functions.

> +			req_addr =3D __hv_pci_request_addr(chan, req_id);
>  			if (req_addr =3D=3D VMBUS_RQST_ERROR) {
> +				spin_unlock_irqrestore(&rqstor->req_lock, flags);
>  				dev_warn_ratelimited(&hbus->hdev->device,
>  						     "Invalid request ID\n");
>  				break;
>  			}
>  			comp_packet =3D (struct pci_packet *)req_addr;
>  			response =3D (struct pci_response *)buffer;
> +			/*
> +			 * Call ->completion_func() within the critical section to make
> +			 * sure that the packet pointer is still valid during the call:
> +			 * here 'valid' means that there's a task still waiting for the
> +			 * completion, and that the packet data is still on the waiting
> +			 * task's stack.  Cf. hv_compose_msi_msg().
> +			 */
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
>  						     bytes_recvd);
> +			spin_unlock_irqrestore(&rqstor->req_lock, flags);
>  			break;
>=20
>  		case VM_PKT_DATA_INBAND:
> --
> 2.25.1

