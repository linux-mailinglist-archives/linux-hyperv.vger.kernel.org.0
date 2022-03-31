Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FE14EE030
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Mar 2022 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiCaSOi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 31 Mar 2022 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCaSOh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 31 Mar 2022 14:14:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADF1DE5B5;
        Thu, 31 Mar 2022 11:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2p0w16rHFD8JtRaP0QhpvKFln4056aI0bXXRQwY7Bx3VuxB0xYJF5kJ4n1eHDMf6zF1JH8i816H+irwfzxIu0wx/ycFMr0Y0O4w/w1bcIQj/kPGczzma43GfwPunZYLBjyKzfk7Y9KjHLwepUxV9cbG9IFR9quyoNgFf6TioDMTMbBZcfwV9Ps8a0gPcEHmxLqLQCqmL7kbatqVED1dJuS6DWE+7At2lhGq8lh6E6SoQR5uLFclPPGoLJ9jkKZqjECaC1oZmmF2iHu0FcJD0EPshnMnu36zP6L3vysBccO47eOsPBY/5iJDQ+bj2aLLrM3Hk/o5mSh29n6A2vTxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCD5aLh1oOBEDHZ0XpFbZJ9TMJgc+C2YQ6Bl+OBnXCw=;
 b=XADFDi3iuRUFPS6O8tjhNPuG+nKCwQfZ3OsCWLdL/BVAd/OnjtEvclFKgEEf6Vy44BVMdV7BDYc4HlpGl3ou2bE6QGI5sBapv8e3S/gEzBxN36xWdJzD1DGYMFruEU/NDJjg+w4uDws9hNsoUL/3RgSE9iwHuiUzZMgpkG3fONysi2UAR8NH4eMN6KCNpxjXWdtTDCzvKUj/7Fss6PBQbtgrBVVjwDQJsJ5UYQfEfraXASwBqwM+ES5q0vfQZkH+9MlgBYZQPlPNnaiJc5F9S+wdrvjKeVIwOGZs0a3aRGu141M8iQAiRoHAw5YKOB56BBMRfmgK5m3e7XUi3tG7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCD5aLh1oOBEDHZ0XpFbZJ9TMJgc+C2YQ6Bl+OBnXCw=;
 b=AGmXNQaxy8c5BR72jbo9f1mSngkXlrv6T0GQHeoRNZsjDioxV6SUSvF0ImqgbG0tvFbSTwNQ8/Y77P53mzcOgHMv8lHqiaJ1EkJGHPCfKUQxcHdQ+rIvC8f5AVSYDyCA1ww6Q47E1IFkkXO6voQvSJaCz1IAxUDnfFH5xEOZ1pM=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1260.namprd21.prod.outlook.com (2603:10b6:5:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.12; Thu, 31 Mar
 2022 18:12:46 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::e516:76e:5421:5b22%5]) with mapi id 15.20.5144.011; Thu, 31 Mar 2022
 18:12:46 +0000
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
Subject: RE: [RFC PATCH 2/4] PCI: hv: Use vmbus_requestor to generate
 transaction IDs for VMbus hardening
Thread-Topic: [RFC PATCH 2/4] PCI: hv: Use vmbus_requestor to generate
 transaction IDs for VMbus hardening
Thread-Index: AQHYQrIqCm6L9YkHt062NoWmtjOxDqzZzWbw
Date:   Thu, 31 Mar 2022 18:12:46 +0000
Message-ID: <PH0PR21MB3025A45FCFD77242EB9EAB27D7E19@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220328144244.100228-1-parri.andrea@gmail.com>
 <20220328144244.100228-3-parri.andrea@gmail.com>
In-Reply-To: <20220328144244.100228-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a3c98da-0615-4355-8091-d2fe41275f90;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-31T18:01:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff5c1261-dc95-4961-27b3-08da13420ee9
x-ms-traffictypediagnostic: DM6PR21MB1260:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB126014D4862822030E8A162ED7E19@DM6PR21MB1260.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9352f+cNA66xL049DpE02z1CSYJX5NRNxUVjXOI1QpCuoaHKJb0fzncITQpC1uDoqd9AhEAQP4GCWRFiSf828mXYESBbswxlsYG2WMDzQGlNYEmiZKuLUK/Cy9ooHfyHjNMgj8swS/iKBoXEcMgfeyUbGf6kXpL1+6ortDYO+9ioiZBLEXwmCko4UWYWc3eaxnNK7WMcNbpZzHlhLBXw5387Q/z5Z6XYj2HNjQfmRs4WloZqi01KSHHNgN0ev7bX9/5w+oDwVHf/8Gobr04EvIpk8Sqp8kwElV/1D2v15bnR9wQPwkgK+RUr7Ih/WYZzzE99m/FCk1LeH5tjloSMTN8q/9DRTtRQrPXD3DA5oMU0U4nUa8KQlXFUCI9/fM0Hp0huWH9kfEg7c9frAiqHLsxycgP92ovFMyXXyHpeIec55Hp+6SiMTaZ6NubzMoI35UXE+vxK5/iTJpRoV42J2R2uA5XjOP66UBsaihBupLgEZReiDHFdW2v4EEu80ViqB7oNa+dSRu9QfIdN+Ag69Xx+7zgP7L9PhQ1YAcgPtrAGXoaDC8OpGeRwodJuRrez+E16ePxcPzVD8x/hzGzQJqIKYEtxDbT/m4TnlzoyX2SzEuuwRtZGdwiBildB/KIbOmjPeWnDF5lwe6dfI/XgWq6CI96ePveYZI6durHGLSWnWsBUSk9ANDAIOCXJb1cZUstPVVd1p9PVC/zPxSnKqGNCp1UGKw6dlwmfiawzf+hUaYePqD+sZ3OCBNXYaDJ7xvIJUzWc1Va7/eVL4jyInQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(82950400001)(82960400001)(66556008)(55016003)(921005)(8990500004)(33656002)(26005)(186003)(110136005)(66946007)(2906002)(5660300002)(122000001)(54906003)(9686003)(4326008)(6506007)(71200400001)(66476007)(7696005)(66446008)(64756008)(83380400001)(8936002)(86362001)(10290500003)(8676002)(76116006)(316002)(508600001)(52536014)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ZdyOaSCR1w1pzw2Yc3SQWFrB+BKFhtM/fh0Rbq67jI0QeL9HAMM4CGJgxeD?=
 =?us-ascii?Q?ev0PJI4jZoa018fVUZGdPZZzJXyKGpYcA2hS0mSavhB5UiwPQOEohMAGcZtn?=
 =?us-ascii?Q?to+9N3tH0s7KrjfXYEb/V4imbzTroszpbIXjpIITmYPQ6QGNRNrlkUu/fVcw?=
 =?us-ascii?Q?Qhj5UuFfe/rzxnVg3sC4VkV7LZW/qkTJpiM5yZr9SEXGuxyuu4BMcVIQpn9k?=
 =?us-ascii?Q?5VdkLskbm9jhYwiE9RJOz+INzJtQhY2w9J1oMoNwcrx4GCB5aXBjaHOpZ3oA?=
 =?us-ascii?Q?vYusg+xeHC/BSUhGZ2ps/M1kO1OR9dpCNDL2pI/Jzrn/nRUP5SVCPUW+krXh?=
 =?us-ascii?Q?l6R9m6kNY7zC4Hoh1fwY1D087yi1ZEAJuzhktuv6yeO9Zko5J+f019FEJk3R?=
 =?us-ascii?Q?Mymgg5nmyoQlYGYO8/DiVv8HQ0MChCpp0Pt7qZLGhqBm8AEsNoZgxlj4x0up?=
 =?us-ascii?Q?fUGkwWzgF2F/XvLFlMHnlUawDbKr1mCmrbjCOnfL9PvpgYYlw9+vbF38lwDq?=
 =?us-ascii?Q?jikYbSVuCUHkhhCC0f77YCNZ72Q1CVTq2Ia2wxNaHcXpiq8n2g5Z+pelrb5g?=
 =?us-ascii?Q?kytzyn8+/9kKLKDySArkskRyvqVhOzGiWhwUHvOogDo99y/eSF7wvXEX4YO4?=
 =?us-ascii?Q?r+9WlZWQLvRhsTmeGa6zGJWV5NvPmmk/yeldtymO67i+ABAt4t+mo27+5NX2?=
 =?us-ascii?Q?SNQwxC041JYT3qZiuk2i+ERk1xpQyXNU6WX3leHuQew0zrg68myd1yUq+wHw?=
 =?us-ascii?Q?qQt7b+tewA2l5FdUMQacyhTMDvmdL/o4hYrRkI70U7VtAmKYF7vzQLv8qbe1?=
 =?us-ascii?Q?19m6DHXPkykLxhW0e9/Xjsv9dhIEjTvL2qBKYR+4jTFZro1wlpA0ArdemEXw?=
 =?us-ascii?Q?2LB3ziktxCnR9dYPIqRHMtUNJUxKdUPVWlJxWogCDEs0wlUmXCk2ksIziovR?=
 =?us-ascii?Q?KHXRtg/ER1yu3gJu0ykAthyB75cVnjflqd2thsSz5byxPcljQkX7hR/zzSEr?=
 =?us-ascii?Q?QvIdJNAZRWTJliJzgsCD4aBi5r6WCPg1MgdRxQRGVeD73k1GXmjJH11z1gBs?=
 =?us-ascii?Q?c0jCG+BBr90objvQhvJzCv6X62iogy85dWUyPgwqFlv30HkRLQa54g+0Pcqg?=
 =?us-ascii?Q?Ap+stCg+4gj0gsY1en3Zcrfe9UTQtadVvhUYWPmAoGzDpX/sbgVzvXVE9vg5?=
 =?us-ascii?Q?xrD2gC8jbN4vNEQddcXy8o96VyGSxLEcSRa+qcZEHIgj7F17uFM07jzRos8j?=
 =?us-ascii?Q?vzeDONcV8JO3ah+B8dxKypMPJXu1YuV765KZ6YX21URSx+GKZjp7hIWSnad8?=
 =?us-ascii?Q?w9Iu4wvQTAlVKseBjXdOHyXzIhWTevoh/TpwJdCPl00IUUOw+IDrm5tiZJTx?=
 =?us-ascii?Q?IJ9edY9/Qc+zQqeWY8Pj3tUU9fkjojEMjxhMAdbZC/f4yyxoc7bu163dZPms?=
 =?us-ascii?Q?StfGTI7g/rKcf9LWu53H8omgEQsCvnVQiRLSk9Z2wtHe9oYL8l5ctfjgzUA4?=
 =?us-ascii?Q?XzGYQKjGVwpojkjNAmTO5DO/QQ3wHDd8oUcvIPrb2H7Vmk7tIaXLpdTaczGe?=
 =?us-ascii?Q?IjogJg5swCZmYMi6xNh3zRd9HDMGXlr2UVwAT7vSTitCwgxk0h44WcYwfRG+?=
 =?us-ascii?Q?TTgMPrifsZELIvNG1mdQWfavfFi8iMUF9WMn24/kKBsXs5PRQMgNKVJ23SX1?=
 =?us-ascii?Q?/uZvJgiVjl5vLKWZuoSpzC3qpgwDlqSdzyXXc76N1JL1UoHTJ+3M8GUz5r/F?=
 =?us-ascii?Q?kjVmmne+2GA0MUQPdRC7+LFcpAfEgZs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5c1261-dc95-4961-27b3-08da13420ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 18:12:46.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4f57ubXyy+tFZALXaTleLlj97SLARAKnT9EqK/8HvOwGIX8Pp1GBtmJBsz3IUrAXT2U2SitE8T/oEqX1zF8gXXBN5wEAOZRcvfm2JP3O1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, March=
 28, 2022 7:43 AM
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
>  drivers/pci/controller/pci-hyperv.c | 30 +++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ae0bc2fee4ca8..9f963a46b8298 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -91,6 +91,9 @@ static enum pci_protocol_version_t pci_protocol_version=
s[] =3D {
>  /* space for 32bit serial number as string */
>  #define SLOT_NAME_SIZE 11
>=20
> +/* Size of requestor for VMbus */
> +#define HV_PCI_RQSTOR_SIZE 64

Might include a comment about how this value was derived.  I *think*
it is an arbitrary value based on the assumption that having more than
one request outstanding is rare, and so 64 should be extremely generous
in ensuring that we don't ever run out.

> +
>  /*
>   * Message Types
>   */
> @@ -1407,7 +1410,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpd=
ev,
>  	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	int_pkt->int_desc =3D *int_desc;
>  	vmbus_sendpacket(hpdev->hbus->hdev->channel, int_pkt, sizeof(*int_pkt),
> -			 (unsigned long)&ctxt.pkt, VM_PKT_DATA_INBAND, 0);
> +			 0, VM_PKT_DATA_INBAND, 0);
>  	kfree(int_desc);
>  }
>=20
> @@ -2649,7 +2652,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
>  	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
>  	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
> -			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
> +			 sizeof(*ejct_pkt), 0,
>  			 VM_PKT_DATA_INBAND, 0);
>=20
>  	/* For the get_pcichild() in hv_pci_eject_device() */
> @@ -2696,8 +2699,9 @@ static void hv_pci_onchannelcallback(void *context)
>  	const int packet_size =3D 0x100;
>  	int ret;
>  	struct hv_pcibus_device *hbus =3D context;
> +	struct vmbus_channel *chan =3D hbus->hdev->channel;

Having gotten the channel as a local variable, could also use the local as
the first argument to vmbus_recvpacket_raw().

>  	u32 bytes_recvd;
> -	u64 req_id;
> +	u64 req_id, req_addr;
>  	struct vmpacket_descriptor *desc;
>  	unsigned char *buffer;
>  	int bufferlen =3D packet_size;
> @@ -2743,11 +2747,13 @@ static void hv_pci_onchannelcallback(void *contex=
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
> +						     "Invalid request ID\n");

Could you include the req_id value in the error message that is output?  I
was recently debugging a problem in the storvsc driver where having that
value would have been handy.

> +				break;
> +			}
> +			comp_packet =3D (struct pci_packet *)req_addr;
>  			response =3D (struct pci_response *)buffer;
>  			comp_packet->completion_func(comp_packet->compl_ctxt,
>  						     response,
> @@ -3419,6 +3425,10 @@ static int hv_pci_probe(struct hv_device *hdev,
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
> @@ -3749,6 +3759,10 @@ static int hv_pci_resume(struct hv_device *hdev)
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

