Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B094F9942
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiDHPXO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiDHPXF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:23:05 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E9106136;
        Fri,  8 Apr 2022 08:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHzqoa7FhIq8oeR6Rny/XzaNJ7Faqw1R2iN8DSKmeraDd3JztE5Bi5J2M4N2q6EwfAY77nBDbFTDF7LRNVNKeUO0rueJGsuHsRuy4RsDYSHRcmPK+C4OteeHmZRlS0QYp2sPrqNvz8NfST9YVSArtexKjR3QhAuqJ0HFRuwOCtKpHQqijsbV0Qdkt5K3zLros/dHfCKKoMG5F5wKLZuX2DIbVicQ3kIk15huEKSNSzp2BHzGeW9PWGOMu+46dp+SWsOp/nP/jqgxoqgrB+poYykuArerfDEtW0gho8F6RhWNjcyagLyJob8mwBrk07Ci9I0mxGUMJUos8HIWZl9j9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY84QR2+JrKW70/qub8dh9hhgRPzRDWPEIisSGgWbys=;
 b=XaUpLJCr8T4mDORyR8r+kYmbqv6wRk8EPaGx26Ec/TCPDLqJxpHoI7SaykfM09500KBkBKFyIZfvFHNky8Jczd5mY+ejQYNJ0M50EsVA8vjOhQFH03L+bd/io/XNnNrRXgONvxZfJl/cprABwkLuSiCexO82WTQB9juI3BWj+NwMoxMlxXhfFSRQi4luPtm5cd9cXFuejcp6wfeKZ7rAIfHnV2QEU5w/mQrTV+nSP24YPUb5dzxUF+lu/8weiLFNgftLVskHOdb1InUjbvFY0mzoKPbUS9/vFSQ1wl5HO3eXvNmSYgoAcheYlfcpWpf5LSk1RWjn/+t44aDBAlp8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY84QR2+JrKW70/qub8dh9hhgRPzRDWPEIisSGgWbys=;
 b=cP6AJ5B2ZrDV8WaVIujRIcozJ7kBfNWV3LD/ooDDE6dJ15u4UI+J9quA+cnfY3eyPgS18wASJ0yKngAfh8r4z1yo+vlGBHaCde7kOb5QPlTF52ybNlvGX3nbMyXDzsDA0kuK7ZcWLUlT89N6UASSWd+KeP00zgFPuD587DlYHIc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB1341.namprd21.prod.outlook.com (2603:10b6:510:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.12; Fri, 8 Apr
 2022 15:20:59 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:20:59 +0000
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
Subject: RE: [PATCH 3/6] Drivers: hv: vmbus: Introduce
 vmbus_sendpacket_getid()
Thread-Topic: [PATCH 3/6] Drivers: hv: vmbus: Introduce
 vmbus_sendpacket_getid()
Thread-Index: AQHYSjh8t1fe6EAQhkmpRN0WBS1kJKzmI9ww
Date:   Fri, 8 Apr 2022 15:20:59 +0000
Message-ID: <PH0PR21MB3025A51EC8C8BEB72A8A2ED3D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-4-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4cb9885d-c7c9-4e0a-9ffb-6ec0cfa9f1b0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:20:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e91daeb-2831-44df-e498-08da197362cd
x-ms-traffictypediagnostic: PH0PR21MB1341:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH0PR21MB134157B9E8150AF40AFDA6C4D7E99@PH0PR21MB1341.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8WjNaqzl4B6aycsVncW9Bh6oPHo7iYzuH8qECCoe7xcGZ1lTDQpK3bdEPEcjh8r6NdEpXOYiRd6LwmUSyisEiI5wDMGjsBKV6AeYgafPR9S5TWe764kHbIVJWjaqfY8RVeaqNZdexpKMT/bu+I8bFCsoD+wgLP+wJe/EgkOhVKxY6b3UidvYqiEjSXy9jj82Uw7bBhl+uICIy2lRsbFR2BYepISwbI3AmjB4jkNxOoLJRDKzdTyvZTSzifZ5Bbjmx8AYjDjpgeI09/hMPa2s7E07b5Fpm3mmYYCkLQmFIrjIQ0iRNpQXIGxDn1yvuL32+XHgifKjH7MxkaJjcOLY8A/lN3OT0Mb7RDgY52gXC4p9pk0ppn3Vfi5rLT6NpuDkUlivh5pYTbhZWKNdKGWGQWHU4wYwE6GqeuRxkOkwQhbKDOh3HnZj1sI1Naj4dHV6BnefGR+x4Nif0vYvA/SWszlEZ8nZg8Is6d42Jhs+tkkS+z/BS0EJ6J/eScRdvrH49AjTl3pmkONsTEvNYHhd2UYjHPB95JBagWm7Fnl3XaouzIhhLO9pEGzInQqNnbZrT/b5zidvRNFJUNxrzsIRLbnqbet9hDbVgV8kHrIhqIiMnacNaNaSQ61ZcOfIUGPuUsb/qLrJPbE0LgDwfIH9WxzEJvv7Lx8/59826qMiGegsPp2bKuXPku/zgfzs/2oePn+mqfziK5ieJvBSKet73P/7WTUUdD3hwXHCE1miqHTA93URyKv18vOHT/gHZieypcRgDvCReX1d+/AreevwCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(10290500003)(7696005)(6506007)(316002)(66476007)(71200400001)(82960400001)(86362001)(921005)(8990500004)(8936002)(38070700005)(82950400001)(76116006)(66446008)(2906002)(33656002)(38100700002)(66556008)(110136005)(5660300002)(55016003)(122000001)(8676002)(64756008)(4326008)(508600001)(186003)(83380400001)(26005)(66946007)(54906003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZjL69JzUUwaAw181HNJDtS1AVuQ5MR8DgcJnTlfcWdfxYlRsfBxLUbTpnfke?=
 =?us-ascii?Q?B8ygv0OvfnifCSKfNuzqXuTBuO/8wbyd+0uOih7CnEm0c/Y7yx+fx7fy08bC?=
 =?us-ascii?Q?QsVrjsv6DteMDDHJHB/Y2oVb6U5Y+3RVI+zp22i6xufUpkJrWHoA3jGVoLaa?=
 =?us-ascii?Q?oIfGgXddFpbLY6GbZHM/PRazgVLx9m9wx1BEyAXGwfniE1HKa0lzk1rvCnuZ?=
 =?us-ascii?Q?3w6XrYQ/35drMsnVdIzEejSWSLWCwKwX7YKxsetBRfMG540m5cFVcRHYVcE9?=
 =?us-ascii?Q?pH1RCKij00Q7s8X5usnekvSX0zUgA/zyZq0zBl9pNSKZffmDgChVYg4g3D8z?=
 =?us-ascii?Q?AQ8BT84pZXSa42NWRR56ukgUjYcd0Ok+zsedqs8JGIS5L7NYeGwE3uOlgd34?=
 =?us-ascii?Q?Cliqs2siaqq6TLagV/TV1KmNR0zahTBWmAXXJ9Y2xndptoH/VokEQFfQtBuu?=
 =?us-ascii?Q?1mjEnHPD9GJEBycFzTxLDWDGAkl2snlsnjke2ef3d5NJ+5b2Cl/NWk76fyQa?=
 =?us-ascii?Q?kgdogImxBHU8cZieQOK96wkIUG+rdj5ulgA769qe+el09lPpyZet1Pekgtip?=
 =?us-ascii?Q?GmNGT36X8022MFvySD5WMWtP9Rqm24u7xirXkuHGXNG+7qxxVpNPuGIo4kjL?=
 =?us-ascii?Q?zlsGkGpQwhL0U21Q497FSxg7Lw7yTD0BL6lGMvpfTj1SVYqq9kHfuYEcCbvn?=
 =?us-ascii?Q?wKA7MoLahkmpv5SeaY3qt8+3WzcmwRqps7tYjKCVUf28JjKRV4BdPPIdZA7T?=
 =?us-ascii?Q?xIha5ujh386x8D6W6SjgBs45dc5nvqyh2JjGiOp9JjSc0suTQKZO4ECuygOB?=
 =?us-ascii?Q?XBfeiLv30LbMj+PVDN3zbyO/2Z/VR6HvhbBUpEQqw2zhTcJPjNXiSm+x8G0Y?=
 =?us-ascii?Q?ldK19CUKaGclo9z3wK+Z/ExGNLFXs2U5M3lZdmKboHiDWlbDm2+KxY/MDRE9?=
 =?us-ascii?Q?Vb9jY6lULCs3u6k6bd4p1DOeW9TT+gfvhxnuobSxsW+sOsthBkZekSsqLZRM?=
 =?us-ascii?Q?pkqGhdMBSerIRqG40S+67Z23FOz6Z5XDfxW5r7yFayRRUKHmfkaVgArxnRl4?=
 =?us-ascii?Q?A3tGsZ+D3eW0r95erpWF3O/xrzAKKkYqpieXLuour+w0hK2YPGrHIq+6vfyq?=
 =?us-ascii?Q?Tva9tqeYOib5NPgqQTElOq5cCEjUMa08Kydc9DMoh76g73nq2l9TK6IJbiDx?=
 =?us-ascii?Q?R/GGJ0UU5sO65QkLGC4BEU7io8EOSfPTZxW7zYeOhOCvbP2bTSxp9tVkUDVX?=
 =?us-ascii?Q?jakA3J3Z7W2XhDtjpU+/WGRQhwuN+rscOfoun+KCWN1+dxQMju9juAgn3dSF?=
 =?us-ascii?Q?KlrK9uOVkeNSNTXlnNInt5oYfO2YKOBU0/1wObpHyzzzdZOA1rnl3hkOm1ON?=
 =?us-ascii?Q?GL3/IU/aRY2I2Iqn2gnnLw0dvIXATtY9ksI80CROBTktNPwM3nseEJxLZI2u?=
 =?us-ascii?Q?RsSuqPOigJxrZFRQvflHNVkz/x6BSWQbhNietELVXcdxx4k/mUmFk0FpFGIz?=
 =?us-ascii?Q?Y4jrHQOgrikZQmdpLqd6AquXCgfveIZrgWCrzI9/bWF4NKsHSW5+B5L5JkvN?=
 =?us-ascii?Q?0QtbPavBE/e5+aQDukYRlUj6DtsV3amMNvei78kaB/Mt7iNU/AbPfk/8xrBY?=
 =?us-ascii?Q?+vBZRJWR4ccdcT5wagNdOpa61txoBp9g86gk7fDkAxAad/u0HJ38wSA8wzTP?=
 =?us-ascii?Q?4lBPmOz/3ESG3HImWgK7CWizalw71gfacWDqfoBVz7ztvIxw7H9dDRiEmsdd?=
 =?us-ascii?Q?F+YHF+2gW4GoPrM5a8dAA8OBrnzNUz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91daeb-2831-44df-e498-08da197362cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:20:59.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCJygHYcIwXcj35hvLPOAPPQ9anQi2YNnHWMx1Gu4gwnT2oqOTs2caX7gsEjTMK5WLieYtOYyoubROF0Ghhywaz6xgfKhmbakhlIdM/GhcU=
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
> The function can be used to send a VMbus packet and retrieve the
> corresponding transaction ID.  It will be used by hv_pci.
>=20
> No functional change.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      | 38 ++++++++++++++++++++++++++++++++------
>  drivers/hv/hyperv_vmbus.h |  2 +-
>  drivers/hv/ring_buffer.c  | 14 +++++++++++---
>  include/linux/hyperv.h    |  7 +++++++
>  4 files changed, 51 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 20fc8d50a0398..585a8084848bf 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -1022,11 +1022,13 @@ void vmbus_close(struct vmbus_channel *channel)
>  EXPORT_SYMBOL_GPL(vmbus_close);
>=20
>  /**
> - * vmbus_sendpacket() - Send the specified buffer on the given channel
> + * vmbus_sendpacket_getid() - Send the specified buffer on the given cha=
nnel
>   * @channel: Pointer to vmbus_channel structure
>   * @buffer: Pointer to the buffer you want to send the data from.
>   * @bufferlen: Maximum size of what the buffer holds.
>   * @requestid: Identifier of the request
> + * @trans_id: Identifier of the transaction associated to this request, =
if
> + *            the send is successful; undefined, otherwise.
>   * @type: Type of packet that is being sent e.g. negotiate, time
>   *	  packet etc.
>   * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
> @@ -1036,8 +1038,8 @@ EXPORT_SYMBOL_GPL(vmbus_close);
>   *
>   * Mainly used by Hyper-V drivers.
>   */
> -int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
> -			   u32 bufferlen, u64 requestid,
> +int vmbus_sendpacket_getid(struct vmbus_channel *channel, void *buffer,
> +			   u32 bufferlen, u64 requestid, u64 *trans_id,
>  			   enum vmbus_packet_type type, u32 flags)
>  {
>  	struct vmpacket_descriptor desc;
> @@ -1063,7 +1065,31 @@ int vmbus_sendpacket(struct vmbus_channel *channel=
,
> void *buffer,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, num_vecs, requestid, tr=
ans_id);
> +}
> +EXPORT_SYMBOL(vmbus_sendpacket_getid);
> +
> +/**
> + * vmbus_sendpacket() - Send the specified buffer on the given channel
> + * @channel: Pointer to vmbus_channel structure
> + * @buffer: Pointer to the buffer you want to send the data from.
> + * @bufferlen: Maximum size of what the buffer holds.
> + * @requestid: Identifier of the request
> + * @type: Type of packet that is being sent e.g. negotiate, time
> + *	  packet etc.
> + * @flags: 0 or VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED
> + *
> + * Sends data in @buffer directly to Hyper-V via the vmbus.
> + * This will send the data unparsed to Hyper-V.
> + *
> + * Mainly used by Hyper-V drivers.
> + */
> +int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
> +		     u32 bufferlen, u64 requestid,
> +		     enum vmbus_packet_type type, u32 flags)
> +{
> +	return vmbus_sendpacket_getid(channel, buffer, bufferlen,
> +				      requestid, NULL, type, flags);
>  }
>  EXPORT_SYMBOL(vmbus_sendpacket);
>=20
> @@ -1122,7 +1148,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channe=
l
> *channel,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
>=20
> @@ -1160,7 +1186,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel
> *channel,
>  	bufferlist[2].iov_base =3D &aligned_data;
>  	bufferlist[2].iov_len =3D (packetlen_aligned - packetlen);
>=20
> -	return hv_ringbuffer_write(channel, bufferlist, 3, requestid);
> +	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
>  }
>  EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
>=20
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 3a1f007b678a0..64c0b9cbe183b 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -181,7 +181,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info
> *ring_info);
>=20
>  int hv_ringbuffer_write(struct vmbus_channel *channel,
>  			const struct kvec *kv_list, u32 kv_count,
> -			u64 requestid);
> +			u64 requestid, u64 *trans_id);
>=20
>  int hv_ringbuffer_read(struct vmbus_channel *channel,
>  		       void *buffer, u32 buflen, u32 *buffer_actual_len,
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 3d215d9dec433..e101b11f95e5d 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -283,7 +283,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info
> *ring_info)
>  /* Write to the ring buffer. */
>  int hv_ringbuffer_write(struct vmbus_channel *channel,
>  			const struct kvec *kv_list, u32 kv_count,
> -			u64 requestid)
> +			u64 requestid, u64 *trans_id)
>  {
>  	int i;
>  	u32 bytes_avail_towrite;
> @@ -294,7 +294,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  	unsigned long flags;
>  	struct hv_ring_buffer_info *outring_info =3D &channel->outbound;
>  	struct vmpacket_descriptor *desc =3D kv_list[0].iov_base;
> -	u64 rqst_id =3D VMBUS_NO_RQSTOR;
> +	u64 __trans_id, rqst_id =3D VMBUS_NO_RQSTOR;
>=20
>  	if (channel->rescind)
>  		return -ENODEV;
> @@ -353,7 +353,15 @@ int hv_ringbuffer_write(struct vmbus_channel *channe=
l,
>  		}
>  	}
>  	desc =3D hv_get_ring_buffer(outring_info) + old_write;
> -	desc->trans_id =3D (rqst_id =3D=3D VMBUS_NO_RQSTOR) ? requestid : rqst_=
id;
> +	__trans_id =3D (rqst_id =3D=3D VMBUS_NO_RQSTOR) ? requestid : rqst_id;
> +	/*
> +	 * Ensure the compiler doesn't generate code that reads the value of
> +	 * the transaction ID from the ring buffer, which is shared with the
> +	 * Hyper-V host and subject to being changed at any time.
> +	 */
> +	WRITE_ONCE(desc->trans_id, __trans_id);
> +	if (trans_id)
> +		*trans_id =3D __trans_id;
>=20
>  	/* Set previous packet start */
>  	prev_indices =3D hv_get_ring_bufferindices(outring_info);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index fe2e0179ed51e..a7cb596d893b1 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1161,6 +1161,13 @@ extern int vmbus_open(struct vmbus_channel *channe=
l,
>=20
>  extern void vmbus_close(struct vmbus_channel *channel);
>=20
> +extern int vmbus_sendpacket_getid(struct vmbus_channel *channel,
> +				  void *buffer,
> +				  u32 bufferLen,
> +				  u64 requestid,
> +				  u64 *trans_id,
> +				  enum vmbus_packet_type type,
> +				  u32 flags);
>  extern int vmbus_sendpacket(struct vmbus_channel *channel,
>  				  void *buffer,
>  				  u32 bufferLen,
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
