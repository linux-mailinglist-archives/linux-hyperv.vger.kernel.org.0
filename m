Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0411951CBC9
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 May 2022 00:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357821AbiEEWEJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 May 2022 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386112AbiEEWEI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 May 2022 18:04:08 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48811C3E;
        Thu,  5 May 2022 15:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfFNIb0WqQ7Q0cS74kEwnNQGwQ6Gl1+1gxLgb4vOEGcZE9hgenzDrbpmno1DBsGYlfefFSxLDh7+gTFyMJU7irw98vlM9/qGf1zJKwbs+jmEXnI7938Io+klLqoVvUi6dIwJrmRjuhsPEH4Zgu0c92G94KdtGfivL33wnLTu4xXL1jI6yi6h4bbxJ7yzUZzEI5ErGdu+Nohfj40/M+Ehgkq3dgksVO9fvI4UyAVjQfcxj1RpN/GzHpktIkYkmwJGNIpkR5wcqEHKDytwSnhmxfvOMr2fOSdkQPxJVzAzBPfpBLJAw+roc6dOApsX1BwrpK8iaKMdMYrVS4sUun+miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTwyU3I08js55lvmkGsAB+sLep8AJEICZ4BxL20Fwlc=;
 b=TBFQRs4OQDD7Y8dDrSNlDTVDw9wsbKy+/O042glHYMdxOVpuxnjqXUv77+1v8RJqPAn6QWN/QaEJMflmjyFomT48lNdEsTIx+8etDK/Wqs4PNS2hPtPbxpwdEDe4zgOHZg5pm//CmBxqhjblqVk2w7qC8zGjBTZY0+gmAkVuEpfmh686Cjn2Ei1pdsH5hj/x6txYhxK2kMBlVm1sjjUdLofk9eipxJeFcMginLZzK/I7Cd8fB9IfCt3cPorvuLwLsK9dztv5ub8FZoj8tXmi4zE9UAUBPflndLS/2UgE+WX36QSiBzo9nndXNt7rKker8MBoL1NuzQjnBkpbs/+asg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTwyU3I08js55lvmkGsAB+sLep8AJEICZ4BxL20Fwlc=;
 b=QvWy3RTYcAjGMHsZED7lD9UF2Wuox1PWN/07vMjZH3QpnAGLZvG/BXCo9Z4z8ub9K2eImEhC4CLTWoizhNvnbtDViIsfK8MB+YU9PoLcOpggKKPFFUO6ndex40cnP2zjzc6tRKrGzNOoxYQOqsbrTem5zZLYxihHBE9pTzi2JUs=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA1PR21MB2051.namprd21.prod.outlook.com (2603:10b6:806:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.8; Thu, 5 May
 2022 22:00:20 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%5]) with mapi id 15.20.5250.008; Thu, 5 May 2022
 22:00:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] PCI: hv: Fix synchronization between channel callback
 and hv_pci_bus_exit()
Thread-Topic: [PATCH 2/2] PCI: hv: Fix synchronization between channel
 callback and hv_pci_bus_exit()
Thread-Index: AQHYX7WhwElYbDPDpUWGUtXwWEAy9K0Q11tg
Date:   Thu, 5 May 2022 22:00:20 +0000
Message-ID: <PH0PR21MB3025226119A4BB25473BC722D7C29@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220504125039.2598-1-parri.andrea@gmail.com>
 <20220504125039.2598-3-parri.andrea@gmail.com>
In-Reply-To: <20220504125039.2598-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=db9f30b9-ccc7-4574-95bf-f92df033c7cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-05T21:59:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 939367b3-7fb5-491c-5a5a-08da2ee2a5a2
x-ms-traffictypediagnostic: SA1PR21MB2051:EE_
x-microsoft-antispam-prvs: <SA1PR21MB2051D650E815B1A9B4FB41D3D7C29@SA1PR21MB2051.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61hMWwGkkiuitfPHODBfckl0bveV5T0dWRqPdeKN9BBVD8dTyy+DhJXn+uim//MAp9CyiGsL/h2S78HRCF31GNmnf0xKnQdUqr9X+tMQ4lyiy50ZJ5v+YwN+Vhv/p90W1VMwZuFSeD2z3WSf+v6d6fKlPfkXm2FmJgRhm+18s7PclU/p3GvUs1riJ3m10g3VuvlsscLEANkJF9Bp70s/Im+8hpip/rLZNybRmzsGXTUaYKf27UVMHVozb3j5BwSwMo2yQ7oPdiPqYOJdi08eQNeYHoYqfYfrx90ckmoe+VLyK0kgf4O6Ex08YiAShq0ls6PXhY44rY1MF0GdoS8ePgXEOrpqZKga5hxerbnz/ZlxqeeBlSJdEGHq3Usqyohsbah5yGuCqNUNJZNFTQfLCgkXyUr4v/EeTkt5qZxv/NG/haU9n5dlNkVrk6shDfkgHZb+3RDCjcw/HQtsQ2EjKOeWGRmWEXDJq/XqpLOLdfU+keztH+sgXaCK1pjJ7OXBVvo3f3SbAMoiJTGWPeUiJONUnvkrPDvSxzvjo9P/TUsiI0vXvpFBTO62fI8ent487WJCPLqpXmKcBCFTRVqE3kYYSyx98E1PoBdhDL/ky5yYUEQjJhuiu5QPd5Gr+XTNSUybHGOkP7p4Fyq0YkbSmw9d8b88PALTyv0LnQMzihzAFBg53lBbYBfvq4KCqRUppBjHQ+YjBcxazRxv3FWIkUt10bg2G2kjECrirytWeADpt8FR8yyDIMJqtP2rpCYIUs19vw4XS+vHWwpOfMxVzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(71200400001)(66556008)(186003)(33656002)(921005)(122000001)(52536014)(4326008)(64756008)(66446008)(66476007)(8676002)(110136005)(54906003)(55016003)(316002)(5660300002)(10290500003)(8990500004)(38100700002)(38070700005)(6506007)(83380400001)(9686003)(7696005)(2906002)(26005)(508600001)(82950400001)(82960400001)(86362001)(76116006)(66946007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k/vGL7L+vgdnAXeM+z3uQ8D9xrHGtA7iFUiy22lL4VIegVMyYRGom4AXA3s8?=
 =?us-ascii?Q?9uGmg3diWYm3hACV7TIAdVDpmq+akYyW4k85IOdaVWjK44XyFZt8efSXuSAH?=
 =?us-ascii?Q?pTwp2hciBfx3vLzCQwudZFsOjV+xFipXdi/m5ZAB9aDKCEkNhCSrH75ZoQN3?=
 =?us-ascii?Q?GRN2HpjaTDiJ+WmlOi5qQFgTOP/ygfzIn5Yl4vO2X0BEJpbKkhCV/kiqy2uS?=
 =?us-ascii?Q?rpHQIKnK1WUGg3OGUxrLF5XjujJEz/8p5eRAWR5BjbrAK9/6CqHaJneYQm/w?=
 =?us-ascii?Q?t3G6EZlWQcS/yRUoYAIE4mi95Srs/GypZlPqkzyb9Sqf2u3AUH/yiDk1jss0?=
 =?us-ascii?Q?SnBTjMYQx8Qo9oLaUlL5NYxQo7lM7uAXsWv6r7Gk8DJzoON9WJxFg63/MhII?=
 =?us-ascii?Q?J0a7p7iF8RBnR70+rkaOx+OAiB56iflDKiK/xh1XHhSeVYdHBaKdDUPTFstV?=
 =?us-ascii?Q?oOIPK8y/oFl6zIEDhEzYpycABl3qSp1Vku3IRTPrY1KfFhskN7BgPZE70+Yj?=
 =?us-ascii?Q?PB+knxAn+5ivBjAKyIaPiX1klB3vhq/IeNH69FXgIj2YLyIXvDopLgGYq9E8?=
 =?us-ascii?Q?1aJwHmNgDkXMdx+G+2A3VBo21S+M+lTkD+ZOqm0IFCsczy0Yvm/tE2/dm0xh?=
 =?us-ascii?Q?lAxVRzpwFh83lwvip1Goe3SNz9fCyej2FDQkrQugScX7XVbyvX2eYBHeDGcf?=
 =?us-ascii?Q?wZt6AvDRAdFRzLmUYzdCDBwGNJtqdRFotoiH7J4lVCn0o9iALs5UElL+EeQx?=
 =?us-ascii?Q?mhPDmfxF4GfD2xNy50RwUIv+PUhCYxaV5LFPBLvmt9KHlEHqdcxs6UFQInyK?=
 =?us-ascii?Q?kIdK/qxrMHHjvdbnWEdikD3baK68bDol1LHwxtdOQW19Ij7Uw7usFlnzfjpH?=
 =?us-ascii?Q?ucgROh0/Zvn/g9HNYQW9VdYlb8LBgyoDSKJcr3hWH56fEFE2reeYF8G/JM91?=
 =?us-ascii?Q?ge5Ef1tHy8o3kSMqvlRb04XCrvqEOHmQBcwr4au2YqPywdvFSYLJXlO2uRT/?=
 =?us-ascii?Q?3z9XALcZE4rfejSQLWzAodBUNXBQWrQD1CGcVlCxwvQ7UIrW6JFAiWvZsELn?=
 =?us-ascii?Q?vru0ilue8rGoxwuUqjU96l+mNZwh+LEyIQ1pCM+iJPrQEzKCtU60BzQB59CI?=
 =?us-ascii?Q?CXH7RqKwkMjLQzJCLcV4+P6f6r/Xg0OdDsq5M/BsVZg1C4VjI1PrOjwFecHm?=
 =?us-ascii?Q?8pDruJXgZP59dzkBlaA/hSVbX3qMd65ZQ1hn7tQ+sFfe9o+1Z9z8jAWE8Oop?=
 =?us-ascii?Q?o0GxYWS5w67qfOPwUDDIQCUP/AO0/q/Yu4Nc07zE0nApoGBWD1P7Z0lxIios?=
 =?us-ascii?Q?tnXmzTHSHq/igKwYT+Sxn8yAkx1YUu20HDjKFu3eaZcIgafQ006lSdXQOCcJ?=
 =?us-ascii?Q?PrarP1VxOlyiWEqBbKK+FmXO794Z1V7nrKuR8WhZLFl9ST566P3qr16mCmOl?=
 =?us-ascii?Q?ZScWb8yNZ5zl2FScQL8Ix1hbn3RSkrNJKPj71V+6Pnm/G+ThxF2uhFxedYVH?=
 =?us-ascii?Q?jVL5+h8Mn7Zs6PcUIkfbRc7ManzS9IGrCdSw8u/TLDylZlhdHMD+Lkke0jTV?=
 =?us-ascii?Q?gs2r1nso8f2j3G3SFvWD+ZsUiMG+b3pL+KzxY7+DK6wPm07bqzANf8Eubs9G?=
 =?us-ascii?Q?P6xHc6+qj6OE2uVHzp0Z/nkZGVoRGYNmDF04Hl/dsXCOeKy8rpBnbQbuUP8T?=
 =?us-ascii?Q?kz0oV90CrkExucZtwtYIfkgpi4BzX7fYwrN4u0vH/udBMMDF2NKlVNaf9o/p?=
 =?us-ascii?Q?+aDxTFWacNrIFWdsUGqpvhgScdZPLUc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939367b3-7fb5-491c-5a5a-08da2ee2a5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 22:00:20.2163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nh4VEazMnrt1yawkUywp9tgYwQKAcGQhX3fDzfNGYpn9lKDRt6bS+8+7wiaFrby+Edzxj9Ep5dC7z5de12Mtw8GgxrSAr/YuVJoBo8qhPvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2051
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ma=
y 4, 2022 5:51 AM
>=20
> [ Similarly to commit a765ed47e4516 ("PCI: hv: Fix synchronization
>   between channel callback and hv_compose_msi_msg()"): ]
>=20
> The (on-stack) teardown packet becomes invalid once the completion
> timeout in hv_pci_bus_exit() has expired and hv_pci_bus_exit() has
> returned.  Prevent the channel callback from accessing the invalid
> packet by removing the ID associated to such packet from the VMbus
> requestor in hv_pci_bus_exit().
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 9a3e17b682eb7..db4b3f86726b2 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3620,6 +3620,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  {
>  	struct hv_pcibus_device *hbus =3D hv_get_drvdata(hdev);
> +	struct vmbus_channel *chan =3D hdev->channel;
>  	struct {
>  		struct pci_packet teardown_packet;
>  		u8 buffer[sizeof(struct pci_message)];
> @@ -3627,13 +3628,14 @@ static int hv_pci_bus_exit(struct hv_device *hdev=
, bool
> keep_devs)
>  	struct hv_pci_compl comp_pkt;
>  	struct hv_pci_dev *hpdev, *tmp;
>  	unsigned long flags;
> +	u64 trans_id;
>  	int ret;
>=20
>  	/*
>  	 * After the host sends the RESCIND_CHANNEL message, it doesn't
>  	 * access the per-channel ringbuffer any longer.
>  	 */
> -	if (hdev->channel->rescind)
> +	if (chan->rescind)
>  		return 0;
>=20
>  	if (!keep_devs) {
> @@ -3670,16 +3672,26 @@ static int hv_pci_bus_exit(struct hv_device *hdev=
, bool
> keep_devs)
>  	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
>  	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
>=20
> -	ret =3D vmbus_sendpacket(hdev->channel, &pkt.teardown_packet.message,
> -			       sizeof(struct pci_message),
> -			       (unsigned long)&pkt.teardown_packet,
> -			       VM_PKT_DATA_INBAND,
> -			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	ret =3D vmbus_sendpacket_getid(chan, &pkt.teardown_packet.message,
> +				     sizeof(struct pci_message),
> +				     (unsigned long)&pkt.teardown_packet,
> +				     &trans_id, VM_PKT_DATA_INBAND,
> +
> VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	if (ret)
>  		return ret;
>=20
> -	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) =3D=3D 0=
)
> +	if (wait_for_completion_timeout(&comp_pkt.host_event, 10 * HZ) =3D=3D 0=
) {
> +		/*
> +		 * The completion packet on the stack becomes invalid after
> +		 * 'return'; remove the ID from the VMbus requestor if the
> +		 * identifier is still mapped to/associated with the packet.
> +		 *
> +		 * Cf. hv_pci_onchannelcallback().
> +		 */
> +		vmbus_request_addr_match(chan, trans_id,
> +					 (unsigned long)&pkt.teardown_packet);
>  		return -ETIMEDOUT;
> +	}
>=20
>  	return 0;
>  }
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

