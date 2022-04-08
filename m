Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906644F997A
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Apr 2022 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiDHPba (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Apr 2022 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiDHPb2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Apr 2022 11:31:28 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB9119251;
        Fri,  8 Apr 2022 08:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gfma/paRIJ/BFfSJ5d5Gtwr/e2pO6zydFYTmKZXsfYPgjOIUuEpdgh4KNLKnl2amkaHez850agzaGUOCzbcKJHnXbfpgVv9dL3j7fATiBZ39cAplsbigRs6F9K6NWqKXSUsFskgvzJ6RxlA+nXfq8IuaYOTUZ93k/9EW94lRL016+0s3rP+2ft/OL3pu+9/D3FRyWG/jvNORD0r/yFvhG4RZuXQz+o6GLhIGzNkkJfp80VCbwkXeyQS42eKTl4ddW1ovQvet1+nODKw2h9vC43LLbiLyU7fX8xEAqI+elQBQHSFt5veF9tAulWxmBYJQfNJlewQsbS91pFz4sgrV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jIHfqevbz1nYFZa3SVNh9Pvkyl5mqUD010LBo4ZU7c=;
 b=ic6WUqRPR+VjMXoos11OWXNNBeoA2YPHLnlysOOtT3vwWk/CNq7AhmYxPz82qhjpxaCpc/WCLVrAZdpj7w6anJ6oDEstjVLfIaqrBoJou+SeXrlrzoZy/rNjLN83mr4G+VJaZ1RiLuTdRabjZdtvMMY+/okbtJ/gbvFFc1gdI0Ok8cEgTQ4lx4fhEdrUmJpjgORF9c6esIjd4pZvt0dyGsB1Yfhhljnk1rAXq+l4HtJhVeKfiUc4Z7kjUCP+NLgwhGO2Or5krYdMrt6eKuznY/UFyvBL3eZ3EznLy1JOs+iuLrNHG2xZo20lwRsgIrYSDg+HNb0NF7Su3IyZ/AJxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jIHfqevbz1nYFZa3SVNh9Pvkyl5mqUD010LBo4ZU7c=;
 b=QXFE6SiXjEk5GFNZmuLkTTkz55y+3JqU7R6AqoCNWBPydrvyfZLNlfnndyolTQWaBfxyEgwvFjApYdalsVG5EflxSsrj9xjuzc9CcUqZChhrxmHBmhlrFGFcAWb5/+jsC1ONQAjfhWgeoanI+vbd6KCFlvlzRki8Fg74mjwFX30=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM5PR21MB1749.namprd21.prod.outlook.com (2603:10b6:4:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 15:29:21 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ac09:6e1b:de72:2b2f%7]) with mapi id 15.20.5164.012; Fri, 8 Apr 2022
 15:29:21 +0000
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
Subject: RE: [PATCH 6/6] PCI: hv: Fix synchronization between channel callback
 and hv_compose_msi_msg()
Thread-Topic: [PATCH 6/6] PCI: hv: Fix synchronization between channel
 callback and hv_compose_msi_msg()
Thread-Index: AQHYSjh8S0Zfsnx3Mk2KxtXKQpnr1azmJjIw
Date:   Fri, 8 Apr 2022 15:29:20 +0000
Message-ID: <PH0PR21MB30258C44AFBC7B522AF17634D7E99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220407043028.379534-1-parri.andrea@gmail.com>
 <20220407043028.379534-7-parri.andrea@gmail.com>
In-Reply-To: <20220407043028.379534-7-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1802cd4c-e85e-4bf3-a2b3-14858aa6f45c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-04-08T15:28:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ba1b3db-a189-4f7b-a971-08da19748db8
x-ms-traffictypediagnostic: DM5PR21MB1749:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM5PR21MB1749CE59A29AB409DA15DE59D7E99@DM5PR21MB1749.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gb/5eoe4hckbm2yqs84lLBoJv414ubBwrAIb7/vjgvnU8djE5W2lBFVEZPf/iIFbsNERw1GzaHgNF3hkzo8cBsZkeYtXvJiArNKsW+KoLoGcUqu8IGvC5K4c3I9dJoMy85D0CLH+hJQAn5yI8CtpcldICFxGTFOeiIlAGZb1J+m51Pe30M17I2mRBl7lWHyxTQb2LyQHptgMfHmAtxl76BG3ZRWZgs1TpF1htxVPMwQmmylQEbqa3F4tATkRgvkHQmkD8Jumy2iA3IO0xRugCv4hELxDvCXjDZfoqzk0MLqqXTlpX2a174U2JLBYwIM8RmdSJf2FGPgFKQrxITT3bGiWQqHWJKBp7lkF5xWF+y8cEdxbKBEZ/Cdg6qS6NIWUx8kYMCyvBe8alLTm7WyhY2JszTBCC9tTV7ik7LXQIrNXbR7ExUgGxMeZap/23NFcJ2du4NyWYRs17pjM3wfHLMu7tnyikkEGX+sh2PVrihamzZYPTLO/8joWZLrRjulh8ix8dXdjkznKhYrOOSPekmTNL8LTkV5yKThHcB1ESB6koFTHEymW64vlm6xken1I1qS9TwvCW1W4l96mdhLCEQf09x61y03yCZl2Mz8YQ/XB0TxwiKrNBwx4EMhYJ4jgjg6Txa7iHdJQcX0I5mEvhGfsAa5eGTXhWm+ddjoq5HcN5TIL9kuyJ2pJ9jDOeOCWGKKec6tPYXY5FIv2esfl+iT/Q7VuHWG7W2UexBC6Je6x9B80hWuhpDRkfPPMIHwnI2YHxHvB4ONX5QQAmRYK3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(76116006)(4326008)(52536014)(33656002)(122000001)(8936002)(66556008)(66446008)(64756008)(2906002)(66946007)(8676002)(508600001)(186003)(26005)(8990500004)(86362001)(71200400001)(7696005)(6506007)(5660300002)(54906003)(38100700002)(316002)(10290500003)(82950400001)(110136005)(55016003)(921005)(82960400001)(38070700005)(83380400001)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bZViXM8ldCSg0NIf01JaafypdiIwHOCUXrpK7wXb5bIssxCl9YYcbWJT7vl?=
 =?us-ascii?Q?IXmATuQd1p+ypbYYz5RZ/Zz/4FwKCvnadwj0Q0CN9t1YdVn9EFCd9mzkIyX3?=
 =?us-ascii?Q?HgVVF2viyTUqoFErhclGVM7xBtyBhtISKsVmiGr4bsAzF7oazCWPL3Ur0fZ8?=
 =?us-ascii?Q?vPujyh7zUDuYQFsyxSe8RZjWzRR8pMuL9CRb4eir17vbh3ByYKSpyRY2tiWy?=
 =?us-ascii?Q?pMoclboTo99POD4Y58oEKjFgyhL8G+aDY5FAT2QthrFDZFumWoA999sZ7vXS?=
 =?us-ascii?Q?hJNetLCo8yq40DZBWu7shm0UpKcaPh4Ubye45U3TTKj/iHTcZD0PB30nDTaf?=
 =?us-ascii?Q?69fcAELq+KjsLOWp4cdaJR2/MNY5cj/0v/ZtKeEwoqUPAgkJO/zRT/O4NWmg?=
 =?us-ascii?Q?ybNWamhwmwuNYn0Xp6WG4gMokMkx/7hjKY6wUKOugx8kKcJgmCgbUK56lPG2?=
 =?us-ascii?Q?08OhqqJRLX0dQ+3AndDchFCz9M+qMm63AHDXCHeWh//Xkt7P6ZDpRSG9/LjS?=
 =?us-ascii?Q?78bHiFECwKH7DNQ4iCoHa6lR1ae65J0XJLoRqrmQ4ACHCpPgTkYWBONa7Cmh?=
 =?us-ascii?Q?i8G4B30EsKUJTUy18e1CkUFu7tGtWyNkL4j9rPwpPl8P2JhE9ZXgUZitwqJK?=
 =?us-ascii?Q?CCIgP0LOeHrDyVgZ+x/55TZsDKkPWrIpwhOiXbwR024rc7OhCppwzla8NL2R?=
 =?us-ascii?Q?q15fnaM+hd2RTRo4ofnEILtjdDcrXxrdMH97PnhHAvY2EKV5rNOgIe34sZ5F?=
 =?us-ascii?Q?eV6UqTIJIto2kXpBSJWuw4kepBjjL6fyT4me2gSYpsV6KCA7uc3lCq233MI9?=
 =?us-ascii?Q?BYdDLG/zGZOtz3nVl7ImlTG5TqP9q2pjNEO8TvbTAzYUpq5OX/azUt/X0YaI?=
 =?us-ascii?Q?iwzlmPVqhb4aRZlJ1Sjbjngj3FDmZlcvrMFoesZY7P031hRUs4vlQ2TdydYN?=
 =?us-ascii?Q?84Znx6xE9wbOFsajDBJXh/5F5PUZyPXjzKPUaMZ5qpiX4f4VcE1eepBCfQC3?=
 =?us-ascii?Q?ndPFKzugpGlIHcOiVnpOeIG58Hr5L09BCgPfKOD4EjwbGI3CGlR9id6ffP4h?=
 =?us-ascii?Q?abcs0ViwuE7sbqPKZ5gSGblJl2pZNIrisRdk8WUML+XH+07irk6L9hRwcUZa?=
 =?us-ascii?Q?iMlFP0eeErlG6qGJyboX+uVLxx+IL8AFjjZD3tYMSRL/29ld7G178+ZB63PA?=
 =?us-ascii?Q?naS2fZsDHUWqABMkQ2cY3LX6HSUskGt93PEby1km+pmGZD8PYUPwIqiXFxqH?=
 =?us-ascii?Q?eE9+9qv1+Z20iNc8y2D2IwqqOOz2N3rV5Y+B7k6Ef3PWsBNs/SUPyn0bvXnN?=
 =?us-ascii?Q?2Wd048Ga4E90KecP2I6XGjEtw3gsu2MMWdgUKDosMOTC3/JM1O5n9Vqv89DS?=
 =?us-ascii?Q?OvZ0LX9nv4u6Grgi/I2LBNRFW4gsuyOd/MUBGpW8lJN9EIiIo24GobMrhNQR?=
 =?us-ascii?Q?67418poH64Dqj6aRnarAqoi+JPKABMHxBuMsoCD2PdcmyxlZRgC1YdFnOumO?=
 =?us-ascii?Q?zvn0McBrY02A7u8WuLoUIPTVU6wA1g3l4EPZt6o3PkS6PPwW6a+Ffd8v1QsO?=
 =?us-ascii?Q?eGHzwFXVuqjRhvbN7aNewTYMFg0corx4aOOozUOOn+hS4g7SW1s7hHt87uPy?=
 =?us-ascii?Q?EPfQQC9ucxGcIqAfK0QcrAZSZxk1m0jlSnA3mEdTJRt52YmLxZ1pESro+FQ5?=
 =?us-ascii?Q?sP3Vf0jQ8iGC/ahzwjsLnNMTeKB0+sWOfV/ilhduC4XkCU2nfiZuf9eulrdW?=
 =?us-ascii?Q?2sf0WFIYA43vtm62tyyOvVVAdJ7kkew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba1b3db-a189-4f7b-a971-08da19748db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 15:29:20.9586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mC2w/ClFFGSFrhzTw/XDn+aOyM/N2gE2Yu+4n/2ZDpHgUKZpkUYDWa4CbK17qkeDG/8Uz3/qbY7VqbOlW8ZVH12fPUWjMOkGbrQHtUJ5vZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1749
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
> The "Fixes:" tag is mainly a reference: a back-port would depend
> on the entire series (which, in turn, shouldn't be backported to
> commits preceding bf5fd8cae3c8f).
>=20
>  drivers/pci/controller/pci-hyperv.c | 33 +++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index c1322ac37cda9..f1d794f8a5ef1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1695,7 +1695,7 @@ static void hv_compose_msi_msg(struct irq_data *dat=
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
> @@ -1757,10 +1757,10 @@ static void hv_compose_msi_msg(struct irq_data *d=
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
> @@ -1839,6 +1839,15 @@ static void hv_compose_msi_msg(struct irq_data *da=
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
> +	vmbus_request_addr_match(channel, trans_id, (unsigned long)&ctxt.pci_pk=
t);
>  free_int_desc:
>  	kfree(int_desc);
>  drop_reference:
> @@ -2717,6 +2726,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_dev_inval_block *inval;
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
> +	unsigned long flags;
>=20
>  	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
>  	if (!buffer)
> @@ -2751,8 +2761,11 @@ static void hv_pci_onchannelcallback(void *context=
)
>  		switch (desc->type) {
>  		case VM_PKT_COMP:
>=20
> -			req_addr =3D chan->request_addr_callback(chan, req_id);
> +			lock_requestor(chan, flags);
> +			req_addr =3D __vmbus_request_addr_match(chan, req_id,
> +							      VMBUS_RQST_ADDR_ANY);
>  			if (req_addr =3D=3D VMBUS_RQST_ERROR) {
> +				unlock_requestor(chan, flags);
>  				dev_warn_ratelimited(&hbus->hdev->device,
>  						     "Invalid transaction ID %llx\n",
>  						     req_id);
> @@ -2760,9 +2773,17 @@ static void hv_pci_onchannelcallback(void *context=
)
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
> +			unlock_requestor(chan, flags);
>  			break;
>=20
>  		case VM_PKT_DATA_INBAND:
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

