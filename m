Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEF4F993F
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiDHPWU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiDHPWS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:22:18 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3735275;
        Fri,  8 Apr 2022 08:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5MXzqTV3UBoe/MuAgi/pPEPxnAEjeuAgILZCgWPwCKxbc00wOYWiIu9UmO6rbDJdgotZPHApi1ivsEkEHYrG8Xww/WHvT8sfJGIo8bu7SlbjLTXPRSj4qSEold+Tc63ei7019w4OB1qiai/BJZ268NMhqFfhoSw38Hoe615cRA64S/KGazMhLw7TYMUNYMyzJJLlrel7HgUA967Bynky6jQwz56qeg9JI98me0gI0g93M9OdVLIcv7T4lpsKUOrQHsO7nXCTcjexrirm+COyh3Y4HydCipPZJrhpMvWSigXNchv1hgFdah1hLUq2KwYicFgKBrf8chTQCjQMc7fVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWVmxXJnhKJVjqYdg7E9lRS5IeF2phA5m9Udi+YUzBo=;
 b=TcHoEkQ5tbGfbbZea/RWlE0sa1QwKDtir4QOgeTwMSv+GgKLifpUfESWplgxJhx6X/nkYvMKoPCKPCqunhIPjSbSB40KZnOj6KrXN6BjL5Pv7bHxAqnGtD/CHrQ0Tb/icmwEiT0bLNfLKbAeadE1dIND5YjJn6m4zZtPZ/F3EFhUjACbz38HsTaJ6PRs+/meAogNy1HRH/OrC4pcs08qv6xGm3ejVL3934dQ2Juue4I6ncxYmHnb+7oQT8NW7tb0KWKzwPvVkE+MZB+fTyAzeELxNnVh2Vfu2kJrqkbVPFOHdr6yIkTwkqt4PdtcRBACkCZ5fAYhlIlazNfV3Wm/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWVmxXJnhKJVjqYdg7E9lRS5IeF2phA5m9Udi+YUzBo=;
 b=B30ZdIxyDyZPNmR6Zyjg1SYGHCyaphm7ngeLGHdmV2NhSSj0j8iliJ6cgJy2gCJ6N4EZYuUO/5K8FF9SPiJVWn6O1v32AE/LFBYKN2PKmWIJoV7+HGScIS9Xz2KOR8t+l4Fx9FC03IZkxr4rkOlpGei3OlQV7DM5a9O6w22hK7g=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1341.namprd21.prod.outlook.com (2603:10b6:510:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.12; Fri, 8 Apr
 2022 15:20:12 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:20:12 +0000
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
Subject: RE: [PATCH 2/6] PCI: hv: Use vmbus_requestor to generate transaction
 IDs for VMbus hardening
Thread-Topic: [PATCH 2/6] PCI: hv: Use vmbus_requestor to generate transaction
 IDs for VMbus hardening
Thread-Index: AQHYSjh19ZDCbbuTN069SFH91pvil6zmIsIg
Date:   Fri, 8 Apr 2022 15:20:12 +0000
Message-ID: <PH0PR21MB302542ADED8A99414518ADA4D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-3-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a85c7daa-1210-4063-af95-b47322760852;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:16:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbb21b4b-ec6d-460b-9197-08da197346d0
x-ms-traffictypediagnostic: PH0PR21MB1341:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB1341221E3A81328F000FEB13D7E99@PH0PR21MB1341.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdJ9smSvaZjIMESQ4Z8rWW/OlhpdQ11aAmSf44tB1/zrAkZwuFu3CIu016NfWHUC9e5YYCAs1R/hhGEbBPar8dOn+aPQW8zRqWaSqk8ngBFf5jVV41hqWt/RVKLQrYjnGvSSaesIbku5vYI1fQ2q+ZlKT32STHr/s4SUtU6eRuZDWwCX1eoGOlLk4n0PWyfqFcKqyC5lFcHlbotmFIOQfuv1Pd7Psk63QuXNEr3t5Gj/AYP9yHvZmClM2nk4NYFxFmZq0RRyKUkz57XTCKihmgGpKS0CeS+VKpa4RMbodIKFgl6A0vo65Ftq6lw7lZO95ia8pylfPgsFiq6JLiKUvKciGREC76KhKMwTNFyAyRi07oPHcbPfPjcs9RUAj4qpG7nVv1CenimYQVqCmZaS1ky6sBOsgaqBK7rYpYmJCn76V+maYqljnns1S3CSCyXM6nSFe/p5f/xr1fOPcjfesbiY7I5vgjRq8Bf6RDsowxNIP5vyxXg3GQg60gyEdFvI3rx7a1puqhQjVVrl6Y4yCeoJta5rWNzNLK5EcQQMyHj23DjWhDf3LZ2KHbjjVzwnmd9jZiSmibjB+g4fgEH/+S1l7YsbAR4FGJcRA2exo7wEDFOkynym01fs88dVQMQMtLtRfGiIoCNjpTKJRrgiE2xHV0kgBBUUXwGRkTKe7VjOhxV5M75sociP32Fsp+9ePIdSquUWCMbOqnDbjR4U+CUIl1NaMyx7DpOqUJmmra/8iQrk7el5BWa6K6IFhR6fAqgc22ZCevE0Rn9f4q20Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(10290500003)(7696005)(6506007)(316002)(66476007)(71200400001)(82960400001)(86362001)(921005)(8990500004)(8936002)(38070700005)(82950400001)(76116006)(66446008)(2906002)(33656002)(38100700002)(66556008)(110136005)(5660300002)(55016003)(122000001)(8676002)(64756008)(4326008)(508600001)(186003)(83380400001)(26005)(66946007)(54906003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Lw47yTq1bqHY7fHF8jZyrrx6qZGKJCrMxTobA2oJpAmMAwraIui73eZvTK8?=
 =?us-ascii?Q?ZNwXyjuDyvVXPa1svtc0NvLh0oRlyJSt0Eg218yI9U0SCkUsyLbLoM2szN5M?=
 =?us-ascii?Q?yQMgDneHIxfCBPEcxEiC0x3zeLTftyBx2YbEIIF7eYxd4hPA15xCHr+KoxQt?=
 =?us-ascii?Q?neSK1gzBBqrkHupS4Vn5fHNCMULFq8guPrCs7zcByLfzLjkrUmcBakFiBmXT?=
 =?us-ascii?Q?BLO2Bt1NCHEz7Q1ESfafIfTRzlxslrzNUX/YGcdgV/M1SjCbAuIvWnnzyva5?=
 =?us-ascii?Q?gfTfrdLPWtsc7UiEWDFic8AgbnWB3Xa4lSdiV+mKRFkXmoSTswYLuW0TqLax?=
 =?us-ascii?Q?Hiciey/J4IQi2m4NYVwamKzB8qz82wHpxSqKryMxnmbhCDAthH+u6p5W9W1F?=
 =?us-ascii?Q?D+zoHdoC5XvSI+Qa2/x/2U0Kk11LENpH3dkYnm+VZFdGxGFvpI6a3zEleWHX?=
 =?us-ascii?Q?ZZ/aEtr/HIv/xGqSeJPJpvY+ke7ZaAfiugD7hlrcYupx0frfTObwh7Xa37uo?=
 =?us-ascii?Q?SezBCoHVmZzochqkfmhQuUTW1mHjfEJTXr4LXDVpMeDH8CUuqN0VIMPn0LLI?=
 =?us-ascii?Q?R7a9wcLkNHk562JqSnm5QPSol9chvn443ndGvlpcJcORgvQ0bnQVixa1Zu5E?=
 =?us-ascii?Q?4Psc7m/tVIAo3VfwJZkJMj8sUMZ8vAkxQL/olu2LZrW8Oye62Mk9G3t7qmAP?=
 =?us-ascii?Q?aQ+n+5mY2RVaEJFa+Gs4WN+ggBbRVsqmgOooKZBs5fhrUg3wXPjYbynE+Llk?=
 =?us-ascii?Q?E+ofGzC1Uc9fj3qG4vrVL+OnSlS4aAYP99Es6E4QMkf4G3sDGKV1Tteep6Cz?=
 =?us-ascii?Q?nFqO/f6ouvSQgj3q85Ty1mEMoBfp3cqhQX//bkulRWygrr2Wh4qWpJI7kPYE?=
 =?us-ascii?Q?psGuUuBtT5LtUla8fSAl0wSnxXidAd9X0R3BNLOf/fuQW4HV0LmSAYLbtWXt?=
 =?us-ascii?Q?EKgTkJHyF0rQiK2Vj5hVTdmqFG9nVg3jSi4vVnKsGkYGqDKXXgmipR1po7jV?=
 =?us-ascii?Q?T7n3UaxE8zv/aEfVbQotwgCOT9wz8TaBGPQvuD/dQlvHJK8dkMYSoXH25QMC?=
 =?us-ascii?Q?OufusO7h/SUTd+SgjJ15um9iXe7h9yBa7bwD9de9Mxl7q+OeUf60XzWs9pAe?=
 =?us-ascii?Q?znQo75qke1K7nre72M6ZT72jWaXGWhi6XVnH22n2a/RNgiPpW1lNStD0+qOa?=
 =?us-ascii?Q?muOq4FRw/iG28t2sW8sy3MoktLpOWf6gCX0QxhVB0Eb4oZQovj9zgiZ8DCBu?=
 =?us-ascii?Q?uLMex2M19V/dAQM1ZSXHTeCdRJo8sXRjnclVZg4SYWKLyAHUyoWeX5GrESQJ?=
 =?us-ascii?Q?3xAsqQlSBRF+xtoTqJJjbp2NZqVxPF0OJdKpciYRw3p3VZCL4LoCUSBtnBnU?=
 =?us-ascii?Q?dHzbFnM8vwi48iR6oz07+oUC2G7zNWJrvDi+WC1GZl1i7xnpagnLRhBrZ1iC?=
 =?us-ascii?Q?YHUPQLXVza0z5UyQ3jhrUxzVtWkb563zn2xGm+ygiZ9kF89Tb/bw2uxvzitN?=
 =?us-ascii?Q?DJUFLsJnvswyErv/i+MqpN5OpZ1GSjOwt2QXYV4J3dc38bObF8X9HZE0Zb7+?=
 =?us-ascii?Q?0JdQQ7XiSZWzKWeXt0GY/WKhMDwzi4+RvIlMvcZlBcF8L00VrqNV1fAhVKDg?=
 =?us-ascii?Q?Z6SIxcmQhRqBqizysOkjp0+9jXFPBk7QLx9LrR1oddJsOyHEIWZxNpJeZ0bB?=
 =?us-ascii?Q?jN8778kmYsiI+kzooBbBG5m8FuIDT+Iea9+sQULthCfgntA+UQgzmPZG//Ch?=
 =?us-ascii?Q?7AW8haWHeE0t0Qz8v/57ICJfTKZXlDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb21b4b-ec6d-460b-9197-08da197346d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:20:12.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woFsQFGTvtoCem+oslNY7aBZQ+zLemfszWatBL1o6C/SMyOS8POlpRealkRl69RrtfZThv99uDpOKTokXvogdWLPiE0NEhluiL3C+nO7KRA=
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
> Currently, pointers to guest memory are passed to Hyper-V as transaction
> IDs in hv_pci.  In the face of errors or malicious behavior in Hyper-V,
> hv_pci should not expose or trust the transaction IDs returned by
> Hyper-V to be valid guest memory addresses.  Instead, use small integers
> generated by vmbus_requestor as request (transaction) IDs.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 39 +++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 88b3b56d05228..c1322ac37cda9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -91,6 +91,13 @@ static enum pci_protocol_version_t pci_protocol_versio=
ns[] =3D {
>  /* space for 32bit serial number as string */
>  #define SLOT_NAME_SIZE 11
>=20
> +/*
> + * Size of requestor for VMbus; the value is based on the observation
> + * that having more than one request outstanding is 'rare', and so 64
> + * should be generous in ensuring that we don't ever run out.
> + */
> +#define HV_PCI_RQSTOR_SIZE 64
> +
>  /*
>   * Message Types
>   */
> @@ -1407,7 +1414,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpd=
ev,
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	int_pkt->int_desc =3D *int_desc;
>  	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
> -			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
> +			 0, VM_PKT_DATA_INBAND, 0);
>  	kfree(int_desc);
>  }
>=20
> @@ -2649,7 +2656,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> -			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
> +			 sizeof(*ejct_pkt), 0,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
>  	/* For the get_pcichild() in hv_pci_eject_device() */
> @@ -2696,8 +2703,9 @@ static void hv_pci_onchannelcallback(void *context)
>  	const int packet_size =3D 0x100;
>  	int ret;
>  	struct hv_pcibus_device *hbus =3D context;
> +	struct vmbus_channel *chan =3D hbus->hdev->channel;
>  	u32 bytes_recvd;
> -	u64 req_id;
> +	u64 req_id, req_addr;
>  	struct vmpacket_descriptor *desc;
>  	unsigned char *buffer;
>  	int bufferlen =3D packet_size;
> @@ -2715,8 +2723,8 @@ static void hv_pci_onchannelcallback(void *context)
>  		return;
>=20
>  	while (1) {
> -		ret =3D vmbus_recvpacket_raw(hbus->hdev->channel, buffer,
> -					   bufferlen, &bytes_recvd, &req_id);
> +		ret =3D vmbus_recvpacket_raw(chan, buffer, bufferlen,
> +					   &bytes_recvd, &req_id);
>=20
>  		if (ret =3D=3D -ENOBUFS) {
>  			kfree(buffer);
> @@ -2743,11 +2751,14 @@ static void hv_pci_onchannelcallback(void *contex=
t)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			/*
> -			 * The host is trusted, and thus it's safe to interpret
> -			 * this transaction ID as a pointer.
> -			 */
> -			comp_packet =3D (struct pci_packet *)req_id;
> +			req_addr =3D chan->request_addr_callback(chan, req_id);
> +			if (req_addr =3D=3D VMBUS_RQST_ERROR) {
> +				dev_warn_ratelimited(&hbus->hdev->device,
> +						     "Invalid transaction ID %llx\n",
> +						     req_id);

This handling of a bad requestID error is a bit different from storvsc
and netvsc.  They both use dev_err().  Earlier in the storvsc and netvsc
cases, I remember some discussion about whether to rate limit these errors,
and evidently we decided not to.  I think we should be consistent unless
there's a specific reason not to.


> +				break;
> +			}
> +			comp_packet =3D (struct pci_packet *)req_addr;
>  			response =3D (struct pci_response *)buffer;
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
> @@ -3428,6 +3439,10 @@ static int hv_pci_probe(struct hv_device *hdev,
>  		goto free_dom;
>  	}
>=20
> +	hdev->channel->next_request_id_callback =3D vmbus_next_request_id;
> +	hdev->channel->request_addr_callback =3D vmbus_request_addr;
> +	hdev->channel->rqstor_size =3D HV_PCI_RQSTOR_SIZE;
> +
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> @@ -3758,6 +3773,10 @@ static int hv_pci_resume(struct hv_device *hdev)
>=20
>  	hbus->state =3D hv_pcibus_init;
>=20
> +	hdev->channel->next_request_id_callback =3D vmbus_next_request_id;
> +	hdev->channel->request_addr_callback =3D vmbus_request_addr;
> +	hdev->channel->rqstor_size =3D HV_PCI_RQSTOR_SIZE;
> +
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> --
> 2.25.1

