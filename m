Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA844F9932
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiDHPSb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiDHPS2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:18:28 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD3410242B;
        Fri,  8 Apr 2022 08:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqQK+RvFbPx3JTQgR/qxmkTFks+FG+S1Tr9y3EbXXkVCzacd6jrb+RmQurMjJYWTUcncOykIqgb7oCCc4nFAioO1ym3ABDmOe66aQmcFfp2Sk0KkY+PK0I7yugGeCwuq+q572N56Tdmu6b7KbLVXwRKOEoPdYuUCFEKCmIX6D3HTO36RrUb3Y/y8fjf/brR6rMQsOh518bU9GEm9QASAyxFT95QKWNz+KVEaiEOF2tSyeTVDIAfm9ectICP/AKObhnLnH+rgctismUEq4usoVQund+IahaHbKsyHnnXamB+Z4GQhkxAPA+kfu06ZJd3jJLQSyA04sp/jTLIx9AXBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouv4pLjnqW+wiQvyWUJaVZEgOJPSLeprtwkM4EivtDM=;
 b=d3+DKSSl43kUS7U5i41WMuwnoIhZw7MwINYOoE8y1SX/8G1Yvo4UOCr5bBpzx68rIbZsAhJtjnsBWy81jMUJ2C4DjVTR4P1xajpRBDGYqPdksD5HJyuWVgKVZikZCnpxeqtiVT795wwgmDctEzv9fTkOrJBYpQ3thJTKQKkAYKrYi6i4YUfbZShRhc8MW4Vz+wAyIgFG42Au8CJfx/Tt5NA9zHX6qJWHVb97wqxwygynz8kEVJT5RU4bmhaPexckU9hLrXF77f0V8+WNkF3ggveS4CAdvkM2XHRpkXAXD6mVDQqnXgVAGSHvVgJGhG5pz3nZgzzwBv5ufgBjAMmZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouv4pLjnqW+wiQvyWUJaVZEgOJPSLeprtwkM4EivtDM=;
 b=J16pS1wH4Qt3SV63gE+XIv6/kQUaKc6AdFFO3A2NtqEG2PC/xFN40fUZJ4Stl7v6RPFhZabBH8ABnF4ebE1CTqI8YdQymM+sxTzmYY2BsoBHGFAm4qTDJuTEF+TWq+72wDDQvDpA6gkGpE0rY1ZXA4EA/seTSgqRJYAVmQ9js5s=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1341.namprd21.prod.outlook.com (2603:10b6:510:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.12; Fri, 8 Apr
 2022 15:16:19 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:16:19 +0000
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
Subject: RE: [PATCH 1/6] Drivers: hv: vmbus: Fix handling of messages with
 transaction ID of zero
Thread-Topic: [PATCH 1/6] Drivers: hv: vmbus: Fix handling of messages with
 transaction ID of zero
Thread-Index: AQHYSjh0TwvmH/rmOEaspR/PqsF2bKzmImkw
Date:   Fri, 8 Apr 2022 15:16:18 +0000
Message-ID: <PH0PR21MB3025CB4163E2974E54C59935D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-2-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a8898754-3e92-4a0e-8e45-75338bdace00;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:15:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb3acf1d-2e62-4f54-d4e3-08da1972bb94
x-ms-traffictypediagnostic: PH0PR21MB1341:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB13411CCD6800DF013CBC06FDD7E99@PH0PR21MB1341.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvXfW8pVlji03BtIed6eKvznpNAOWzcYc7E9JFV08471824RSFx2X01QJ1qBhzomV8xpIKiMCkG9bXZd59tdcJ7gpSlYHYAOmiROrfsjgYdTqLpRMnYOMr8jiaYQg4fffpTfQCrFrhl6PPw5SWSKoIRj7PpXnCL+LM2BirgjVGa9L5gnTjJPWW+Wre43v9W0BqIAl162xFP5zWNrlOHUK3CLDR0SV4ryL5QGUyd2b8XdLCmNagIxKvy7MNM2n+42QvPekw7+IsK2OK4wA/CHmZORe9CkvFmKs10UmP7EZhzcQvrSf/LBkKJSp522OBrWJSDyyfzX4rYpzlJSu3PKHQL0GgwzepkynQwKbcbpRggSR/v51k+4Q3o86sKxWj3TKvgmMQhdfLcLRQYI3kR3engTaCj3QC7XtX0CVbJwuh1kpeDSzPabzn7QJGe4fQYHgTCQo7xRSw9ZWYPaXSfGzuCwOgxfx2WX5DGwmERwsb5pK1kc7VXEJPaF0dgdUEBp0i9NeLU38Fk2w1gloA7rbNBAlC5k0nRUEP2/7k12FIUZ+aireaOlDhTDD5Z6PmSwYJRzJE0f4l4rgBVq2h2be1XdFCsqteKr/k9FMXso17I0yzyo38ttWyBzVsNyqOVA1UFOTPDvwLCCPxVsY/zMh2qnWS/holeNu1XL3g7bmQaQOf4mP842PrIuF24ujMUsdsguG/irq3iXLhlZY6JLSAMz/V0Ss2iu3fSNbeZzC4ez7bx0c+f9ynEX79L9oApmq/TAdxTwZAJGjNoCFAmvCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(10290500003)(7696005)(6506007)(316002)(66476007)(71200400001)(82960400001)(86362001)(15650500001)(921005)(8990500004)(8936002)(38070700005)(82950400001)(76116006)(66446008)(2906002)(33656002)(38100700002)(66556008)(110136005)(5660300002)(55016003)(122000001)(8676002)(64756008)(4326008)(508600001)(186003)(83380400001)(26005)(66946007)(54906003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zdq2mN0JwMZaXLsx4VDTgOjFoxEZgc3MMkzpBHGWvR2vfHtKhBSUv0fOY6O5?=
 =?us-ascii?Q?EmB7YFHv78R7hLSI8F2cIHrnvsj47H4xhTPCqPc2kfxFyGOhhyYbBJZX8M6x?=
 =?us-ascii?Q?NyR/XtkBrR15jnKmWWnN/UKsmyuCm/A9AeoWdnNFfaZgwCF69jJ4f02kcpod?=
 =?us-ascii?Q?ThIaikc5Ya9fyB5DPNH5YJwoGtsLSgTA7f1pTzNKcPDLqZmHYLLiYq7zqyi3?=
 =?us-ascii?Q?iWHeyM1GPv2sKjyY12PHjUBO5aJSBnTIzm1fVuys56L/8zXsuoNfwGgegdsX?=
 =?us-ascii?Q?fXaQFjKnBq+vI9MKPp8HUs4CxGNwhPoG7CAabevbJJhB5CNBGRfkRVihBSxY?=
 =?us-ascii?Q?1pA5AnAaSlKoKLRsJ+e8f0e73VlcYP32zIRXrfgqfo/WtwLq74zvcTaBMhh0?=
 =?us-ascii?Q?yiuyoaYuRZCecV5QJGtmYVFIcV9SAlztTtF9nlkE4FzSn6VK1Us7CGkXFIzu?=
 =?us-ascii?Q?3s0/rvtqrWmIw34qgGy8IXh8ugGSxN8jNTSUYb4gKZeJJYPX+yOpqR6lMcw/?=
 =?us-ascii?Q?trUhBvt1hwZQZBfhRwtGeFodCKhiQCO9115dsAQKvBpmzuaRCqM4CPd7+fGJ?=
 =?us-ascii?Q?E+Smw77g7MtekT+RU3B0LU8hyaxjeAH2ICfdfbAc8cfNfAyyT9VnaQlMbwxd?=
 =?us-ascii?Q?i/jQe/86K7r2fNkO1EHbvWOgWQhgVWJAoFolBmSxUUGbDln7gF7OqR8geDpG?=
 =?us-ascii?Q?HQ/ksC8QA14CHNpHPQ3jC9Hq5Xb+OFwViEJfu5rIaJiZwlMOIuieObqgGRAS?=
 =?us-ascii?Q?555Cl3pTr5hrH4ryzh2mqV/5miLZQjqIC6vtqVGB6ti+CDGzRuzr8h36Nf4r?=
 =?us-ascii?Q?3QGmDftKe0tYVRWXHuKZGHeRdc4KbKAWqKiRflvzlReAecscRhVBm+JfF73O?=
 =?us-ascii?Q?iWpuaXo8Hrutx9y+xEuSIuKC23S8c/QeiamoeneQCOmPGtRmZ02gxfQTjOyw?=
 =?us-ascii?Q?KcTSTSQpZr1F+hWBQy8Rp5NRO6plm/GVJ0BBWp97kuBrwjfmtweaT/Q6PNyp?=
 =?us-ascii?Q?4SICNPi3+mdcKTeIGNqUjfCs+QA5FpeJxiSwKjiToxWiWCF/RAKwb9+9dx/n?=
 =?us-ascii?Q?F6NIBCMhvnenmZf9PowhkPOO1Q6aHMb4fe+EAYCcq+Vh0WizzesmDUlFG1FD?=
 =?us-ascii?Q?FqSCbcL8BhQNCyLuZ0ky54H1XLC4V5jMqKE0h9wvlI7V06/d0VbieNNvTvtw?=
 =?us-ascii?Q?J97MwMYgcKrHVm3qi1cg59yMLfRFE8dIFZYERcYjAloZdCaXlE5sE2tEvnpG?=
 =?us-ascii?Q?7NcI6ImZaaNFyM4b/XyegMKslVPKVtBRZ47rLFnD1Cdu4OVwoX/J1CxC5mvI?=
 =?us-ascii?Q?x8sIyVaRwIYMKdQmlewYNM4FvktoqbiFk0juqk1xwV8aY5Yd2wOvUT3l7MfZ?=
 =?us-ascii?Q?ckjJtQe9uc1ZRsUluU+Vk5UXK7tjlD1LYmaAbSBE0UkjwiYmmnpEA5XSeM9W?=
 =?us-ascii?Q?Y0OHbaKjzxfrrb8HBiT82oCY0SKOHOsZrveximW5nKVobKcY/cEq7ezspxJu?=
 =?us-ascii?Q?m//SE7hkG/o/j6O2j6J9mY80fxZEoRx6Ud6x4Sdnj6xBwO5jVx9Brl52Tr7X?=
 =?us-ascii?Q?1x8/FmOwuvf4vRCvnbXQizCurX25mSj3s1zolP8ByUTAt/HIxfRxBbepUjip?=
 =?us-ascii?Q?3k9oTsUHtqWgNXT/OBJfOAZa0jE7xupD/yElL7LCw6V2Qq4HYBsxi/AULWK2?=
 =?us-ascii?Q?mE3qaazFHbTm+8LVKIhAb8FafkXd+pCFQ9Iv1JMIFx4mEDvIRuTk0sOh21bq?=
 =?us-ascii?Q?C9r/g53DLSImZd8bc4M2EaETUnmPzv0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3acf1d-2e62-4f54-d4e3-08da1972bb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:16:18.8755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72c0Dbl+yh3vArTWFgmHksunW9jzNvEsiAZ+wtQM+Gxjcu/EaZTbqDO4VvPpQRxnK5vQUUgOH9yh4BJ6PTkisCYVnjiZn8UJVEW38K+8DRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ap=
ril 6, 2022 9:30 PM
>=20
> vmbus_request_addr() returns 0 (zero) if the transaction ID passed
> to as argument is 0.  This is unfortunate for two reasons: first,
> netvsc_send_completion() does not check for a NULL cmd_rqst (before
> dereferencing the corresponding NVSP message); second, 0 is a *valid*
> value of cmd_rqst in netvsc_send_tx_complete(), cf. the call of
> vmbus_sendpacket() in netvsc_send_pkt().
>=20
> vmbus_request_addr() has included the code in question since its
> introduction with commit e8b7db38449ac ("Drivers: hv: vmbus: Add
> vmbus_requestor data structure for VMBus hardening"); such code was
> motivated by the early use of vmbus_requestor by hv_storvsc.  Since
> hv_storvsc moved to a tag-based mechanism to generate and retrieve
> transaction IDs with commit bf5fd8cae3c8f ("scsi: storvsc: Use
> blk_mq_unique_tag() to generate requestIDs"), vmbus_request_addr()
> can be modified to return VMBUS_RQST_ERROR if the ID is 0.  This
> change solves the issues in hv_netvsc (and makes the handling of
> messages with transaction ID of 0 consistent with the semantics
> "the ID is not contained in the requestor/invalid ID").
>=20
> vmbus_next_request_id(), vmbus_request_addr() should still reserve
> the ID of 0 for Hyper-V, because Hyper-V will "ignore" (not respond
> to) VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED packets/requests with
> transaction ID of 0 from the guest.
>=20
> Fixes: bf5fd8cae3c8f ("scsi: storvsc: Use blk_mq_unique_tag() to generate=
 requestIDs")
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> The above hv_netvsc issues precede bf5fd8cae3c8f; however, these
> changes should not be backported to earlier commits since such a
> back-port would 'break' hv_storvsc.
>=20
>  drivers/hv/channel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index dc5c35210c16a..20fc8d50a0398 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1245,7 +1245,9 @@ u64 vmbus_next_request_id(struct vmbus_channel
> *channel, u64 rqst_addr)
>=20
>  	/*
>  	 * Cannot return an ID of 0, which is reserved for an unsolicited
> -	 * message from Hyper-V.
> +	 * message from Hyper-V; Hyper-V does not acknowledge (respond to)
> +	 * VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED requests with ID of
> +	 * 0 sent by the guest.
>  	 */
>  	return current_id + 1;
>  }
> @@ -1270,7 +1272,7 @@ u64 vmbus_request_addr(struct vmbus_channel *channe=
l,
> u64 trans_id)
>=20
>  	/* Hyper-V can send an unsolicited message with ID of 0 */
>  	if (!trans_id)
> -		return trans_id;
> +		return VMBUS_RQST_ERROR;
>=20
>  	spin_lock_irqsave(&rqstor->req_lock, flags);
>=20
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
