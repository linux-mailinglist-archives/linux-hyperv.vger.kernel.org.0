Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5495071EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Apr 2022 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353914AbiDSPj0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Apr 2022 11:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349390AbiDSPjZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Apr 2022 11:39:25 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70813FAE;
        Tue, 19 Apr 2022 08:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwzG7UOmFtNMA0fGQhcIr9fSrZ1qa8hWilRQ/yh6n4LFoSdS1Y8qffwJjBx1zswzLgWNFcGJKE09F997VTJYCBQ0RTcE7kf0cnA9/KLjQIGC9N8eh9Eo2eCaQ8aIWEszu21oVX60SHxhoqqaJcZoyf6sKq+VHJ+oeYQ6FN5kkKzs8kSu2E7mymfAn1ugt+ur9jYX1zdpa8i0MJrfPKHLXW0CLMGlL99aAIkk0DlDfgyQMuemM7CeVGu+fLURufid3hR4zFqGhAHnyM58hMpVtXVzrWp+sM3L2ilffcbZOWO+lzgFZs0FQ51Qd9og12PTX0i65le71Im52ep1aWiciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUWPVHZpwcwWANZxmxylt8D7kl3WBYVxhXWDgQZ0QOM=;
 b=nDY0XEPBtLWsXNIztF1aPI59rRyaYe4I1yLU/YI4qqC1XVk6oc/nLnjGrsDb6q1Vvj0HxgvV1jRMGFeSDy1BZGvIuudvZVYYqKqNZ42rxQ/6tyv0cQ5le0BMO/TukGdU/9DDLcqKv537TmwLY4gNvkHO5m06m6eo3hQVUzJuBdWl2QpGTbi60xE9BzJtdSCzbWs89iD9kzF+t+BROEb8eW+yBsT3ftrZaSC9zNOxer1n0WFMT9dsN2y+Nb3BY60jpxPxi8sFfK415SnDznYRrN17bquwdassg4uU7yo0OnohWrsp2+Q6ABE/G7vF+aC0Rn5bhqx3Y0u+5BTsAF5u9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUWPVHZpwcwWANZxmxylt8D7kl3WBYVxhXWDgQZ0QOM=;
 b=Uu8ZG4N/fRQj7Y2NG1Rf0lzIOwjW2WMCKqvqvT6uEUxRiXqmgfe2wWLPz8+b/HLCk7Z7qfyXVwoXUaSsWK5jx6X9FrmnMWuQGmtQu6d2XyoEC3Qje+GRO17n4I2yxxvCrTd84Bvgq1RKtziitp/pzBP6TBup8BuNYu7jIJGglJY=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BYAPR21MB1285.namprd21.prod.outlook.com (2603:10b6:a03:109::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.4; Tue, 19 Apr
 2022 15:36:39 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::cc99:c6bb:dfe0:261c]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::cc99:c6bb:dfe0:261c%5]) with mapi id 15.20.5206.004; Tue, 19 Apr 2022
 15:36:39 +0000
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
Subject: RE: [PATCH v2 2/6] PCI: hv: Use vmbus_requestor to generate
 transaction IDs for VMbus hardening
Thread-Topic: [PATCH v2 2/6] PCI: hv: Use vmbus_requestor to generate
 transaction IDs for VMbus hardening
Thread-Index: AQHYU+haOn7fqaesC0+cCj57snAjPKz3XonA
Date:   Tue, 19 Apr 2022 15:36:39 +0000
Message-ID: <PH0PR21MB3025AED25A79AAD81F0F0FBDD7F29@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220419122325.10078-1-parri.andrea@gmail.com>
 <20220419122325.10078-3-parri.andrea@gmail.com>
In-Reply-To: <20220419122325.10078-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afa985b5-9dd3-4cc9-9e49-2c51cab48008;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-19T15:36:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bacfce45-c3dc-446f-61f3-08da221a65a0
x-ms-traffictypediagnostic: BYAPR21MB1285:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB1285D1C9C7A114836AD6E097D7F29@BYAPR21MB1285.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/YlljyPHvrebVrhna+KX2ElYsaarmIKrDq0sQWVeXN38+/SuW3Y7HPAgdkNckfpu0zTYPUTmFWU8WMnbFyh5G5NIVK1RkDnNkPakED0VQbjGLxOGkiIGLnVjyWxFMGP26zhQ+lhzoAetKr6mhrnfCxIl0XGBTbSsteTumixjEybJtB/jOK4emqEFvbPjC96BtA0yCpjEdiE2UBJ754eVBzVBUre3bQDl0FoVV/jP8DMd7Hogpiuqt3SFoaPoLVwWOUub8fYqAeA8fTQjfJutaWwygHN4jn5bboePFZa3KJyZ/HEa1qEuI/eCnL1lumVCK+s1dMtjr+2cRYwRsul5lQtCNqz1LLYEYkLuCKRrZa/sTGvRp2+7+6WR6dT0nA7y6s2tmwcxPRpQDOD4yeAAWFNM3hp8RfZzRqNMdyQCQmZDQHg2DNxj0CRinhOBe/Ovu2rsa/BVDSLUWIWnhOodaKYO49huSw3Vg7OAfChVnxBNy0zd0dmabCDEnZvz04PKkROU3ag20nmhlY9pzwroVTojkJN3PVlTM+pwdJdZcpBPY8OWbGhkwRGxbHyqojFcrmw8elA37RWE/FfCvztunKR/chFLlie0Iij1MROVfcxEv10nDKoM9EFx4NZEicdVSiDEbxpAl2u+a9ubTD20TivGelRKEuG0ogVcm2KE0tkv+X/CpJgVaTfXW4OIsN5XJdxSz1s6ouPYFLM+yECDx17MCfFnraiybaqgj/y5G9o2UUXOT/G0vg1+Oz/0S32l36Ojo1/EbQaQlTcpJOmeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(921005)(122000001)(82960400001)(82950400001)(38100700002)(38070700005)(8936002)(5660300002)(52536014)(4326008)(66476007)(64756008)(66446008)(66556008)(8676002)(8990500004)(55016003)(2906002)(76116006)(66946007)(508600001)(7696005)(9686003)(6506007)(316002)(10290500003)(110136005)(54906003)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?34OAKgeF9WWREU78NCpJHwXAIvHmhMI6+VLVuaLzEFDGTkYsm0C3vLLFh0Zh?=
 =?us-ascii?Q?EZ6arRcyTv2JBo432kCA4FRzSlvPrkq2g8VAcf00cTywqva13nGX3TaYmLCv?=
 =?us-ascii?Q?2vBMBjPfpSDaiXgbIl9xDtcAWhbnQZHKdYPslxFG8gTiaMqcww6qruFhffyG?=
 =?us-ascii?Q?1lmW07GrH3CfNoGELu0nU2Lv4P+uccuZxPSWULdShwlfKUILfgHxHu9WjMBd?=
 =?us-ascii?Q?KprJEQVJsPRxD2lpZrmJO0RBdPXddR7JHE0gANaXw+BRBORh4ns6Z55MsVsl?=
 =?us-ascii?Q?pL8pgMNB+Y+3Fom+HZTptvnrHlVDgDf6+5pbqzmjd/m/HTkzyMhNPZUwqG3M?=
 =?us-ascii?Q?C6g73f6v98eyJx5Me0S3ZGjIipXaRvm0nQPXzMsySgbu2bTxl6D+MwP+R7yv?=
 =?us-ascii?Q?sBpqjuxMHSytqoEh+BM8pSGIHW40mVjYljbn6dRgWx4n40/EV5oLrrOYaxJV?=
 =?us-ascii?Q?FkC9Xnu6qUQze+MHiAAQNYIGaRFcPzyO51wCCidj+bzAkCmJXu+NEfn0ibir?=
 =?us-ascii?Q?K62j3DWirUmQ+OP4LydnWDchtG2jkoYdAfKUw9EN3GhI04I+743sXFnmcOXi?=
 =?us-ascii?Q?8GiK9kUJxl8F7GuYaG8yDcXaGdpiKiLKOQHuPOvXzCzoI22gF2C6DNGj0OFx?=
 =?us-ascii?Q?JfZ2fxSI8QHNCRe+dmNbg51RsXFiSjDUG7HKrcg7SYa7oygBQzE5SulbQnqv?=
 =?us-ascii?Q?vP8spCOrYHvx92Ob5qwR+zj8KPUQuYyYeCW7OtCMRQzxnFXCWLNop+ZCLW2k?=
 =?us-ascii?Q?CuskF4qdEBvXThkVBoKE0BI6Khws9jbzEEdEVRVa/OMEkykYtPx4YE2n3aEu?=
 =?us-ascii?Q?q/6w+QFrTT3dGSeKMTzsQzoqj8sw6153CZ+TkcLU0zWuHbf09lm/hqqfWl6I?=
 =?us-ascii?Q?Y3eFlPHeOIsQxoZkrVQqZ4qaYwLLiWByl+Em8YZzjbdC83xvquX9iaVM5gca?=
 =?us-ascii?Q?+0Hm5tmn6PXAg47ykzqfxH+1iU6IRPc/JVPj3tFCIcX44V+C6vdMlOuQ0/Ox?=
 =?us-ascii?Q?93BpyrJPzrv8C/s/NuSsLGPHgw7WBf0pTQI58zCh8OcfvpqDfo/CYUSSMI6P?=
 =?us-ascii?Q?Ci3A6yNlvu624XFxTHPM/RX3nG1lrSFq7m/lKUPJLG2tzBl6N2CV/Cx3Wlve?=
 =?us-ascii?Q?RoQgCIJGQlk/ZEmDEOU60MhPyyEvARyzSzIeJfAywY6DNErm7wmx6x4HNAd/?=
 =?us-ascii?Q?fe1JDRi7d6RLWODfhLS01TDhB1ia133ONIF3w0/gA9MaxVu+7ho6zyLdmALV?=
 =?us-ascii?Q?QJyBdOjIaLoO83BMkvqXx9DbyEcpbPNVcqInHOcgEUM7/Z8VbA2w67fn//Eu?=
 =?us-ascii?Q?l+1hDimRFQU3uXIsoLGfoUioD7OJKJSaxx1Y77dARhiT0vxorBhi9/fcRWFj?=
 =?us-ascii?Q?ji8iuFa1o9n4HFkL8Y7oObLhtkr5gllQPlWyZ4yTEdJo160xA/wW94xD6Jug?=
 =?us-ascii?Q?asXqjtbNsiYZgvXdLaVSjdd4Wqd/4htCfzTniBnWLAg8XuieJku534/rp4p4?=
 =?us-ascii?Q?y5fHUdyT9Wuusk/OVcBnDWNQjCYHSg150QXXEglbHNHSAdHQqYZn8p6NhbCW?=
 =?us-ascii?Q?+m1QE2q+mjBXqaatv29S6LWXRb+4GKPKlv5XXfkg8TuFRMdk+mQ61aDJGeJf?=
 =?us-ascii?Q?dPH0+OXzpCKo160zslHXNO9hSL+4TehoEwrPQtdvyOjAlrISzDnU1Jkx9yZL?=
 =?us-ascii?Q?fKwtKGE3ZfSz3KSS3heho3nINnlZHKYF26rmn4o+iIJWuqNSWawe/1IqAbLi?=
 =?us-ascii?Q?8xWfzDnE8DbwhTt5mZzmc0COtqBokGw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacfce45-c3dc-446f-61f3-08da221a65a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 15:36:39.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xPLTXOALZRWI9TIi46j/iZdT3ez/xyMBMvAJhhDVGMxVys8OFWXD8Ik8AKj08Obw1gWz+wXWBy6BrqvYyMmfKTqrl4Gs5w8FT8Vc081AbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1285
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Apri=
l 19, 2022 5:23 AM
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
> index 88b3b56d05228..0252b4bbc8d15 100644
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
> +				dev_err(&hbus->hdev->device,
> +					"Invalid transaction ID %llx\n",
> +					req_id);
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

