Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1A4C8F95
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiCAQCt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 11:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiCAQCs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 11:02:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A6A145F;
        Tue,  1 Mar 2022 08:02:07 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221G0rsD008364;
        Tue, 1 Mar 2022 16:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5bY54GIfqV2Jrj+zob+Kzfp/785R923S9y5UdokMSTY=;
 b=cTEjWFiDoDzgklnz8XmCDBVZZf/EOFyYKgfKWFVqfwcKr/T2QDXQFlsGiZt4OWQAdMGq
 4adsleM18NBEfaEqHRN9Bu2TiHQi5YqOMn1patOrp6CI1m9QLvFatoDeXXAHnVZPKWuN
 2L/4TUqPCjstjNtIA3M7DYAqxnj3hHVn7Vdzm5R0gE/DjuCbMqv3e1gZMp/EwNbcWDDa
 C3w69dyAlov+VJ+AbcHXTaFxawtdMD4YDgnIaXMAZXvuRD8VSbRZT26N2yA5pph2osAg
 NT8AvoDYJxYcKFUfwe9e7/YTOHs8NqCNp3i3RxhPQ6RHwx8j2Z9FVUnvuiiANKuSB/AG OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpbn8haj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:01:38 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 221G1b7O011765;
        Tue, 1 Mar 2022 16:01:38 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ehpbn8h8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:01:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 221Fw2Vs007708;
        Tue, 1 Mar 2022 16:01:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3efbu9b25b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:01:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 221G1QKg43450802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 16:01:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 346CE4C050;
        Tue,  1 Mar 2022 16:01:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE1C4C044;
        Tue,  1 Mar 2022 16:01:24 +0000 (GMT)
Received: from [9.145.23.254] (unknown [9.145.23.254])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Mar 2022 16:01:24 +0000 (GMT)
Message-ID: <b2295eba-722a-67e2-baae-20dac9d72625@linux.ibm.com>
Date:   Tue, 1 Mar 2022 17:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 06/11] s390: cio: Use driver_set_override() instead of
 open-coding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135214.145599-7-krzysztof.kozlowski@canonical.com>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20220227135214.145599-7-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VwR9OiefAhT359vuW89HdrkWzjVzSJvV
X-Proofpoint-GUID: 77Yd1MtoDGNnH1_0a7MDCf3mUHkKdN3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 2/27/22 14:52, Krzysztof Kozlowski wrote:
> Use a helper for seting driver_override to reduce amount of duplicated
> code. Make the driver_override field const char, because it is not
> modified by the core and it matches other subsystems.
s/seting/setting/

Also could you please change the title to start with "s390/cio:"
instead of "s390 : cio"

Otherwise,

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   drivers/s390/cio/cio.h |  7 ++++++-
>   drivers/s390/cio/css.c | 28 ++++------------------------
>   2 files changed, 10 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
> index 1cb9daf9c645..e110c10613e8 100644
> --- a/drivers/s390/cio/cio.h
> +++ b/drivers/s390/cio/cio.h
> @@ -103,7 +103,12 @@ struct subchannel {
>   	struct work_struct todo_work;
>   	struct schib_config config;
>   	u64 dma_mask;
> -	char *driver_override; /* Driver name to force a match */
> +	/*
> +	 * Driver name to force a match.
> +	 * Do not set directly, because core frees it.
> +	 * Use driver_set_override() to set or clear it.
> +	 */
As Bjorn Helgaas mentioned, please wrap this comment.
> +	const char *driver_override;
>   } __attribute__ ((aligned(8)));
>   
>   DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
> diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
> index fa8293335077..913b6ddd040b 100644
> --- a/drivers/s390/cio/css.c
> +++ b/drivers/s390/cio/css.c
> @@ -338,31 +338,11 @@ static ssize_t driver_override_store(struct device *dev,
>   				     const char *buf, size_t count)
>   {
>   	struct subchannel *sch = to_subchannel(dev);
> -	char *driver_override, *old, *cp;
> -
> -	/* We need to keep extra room for a newline */
> -	if (count >= (PAGE_SIZE - 1))
> -		return -EINVAL;
> -
> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp = strchr(driver_override, '\n');
> -	if (cp)
> -		*cp = '\0';
> -
> -	device_lock(dev);
> -	old = sch->driver_override;
> -	if (strlen(driver_override)) {
> -		sch->driver_override = driver_override;
> -	} else {
> -		kfree(driver_override);
> -		sch->driver_override = NULL;
> -	}
> -	device_unlock(dev);
> +	int ret;
>   
> -	kfree(old);
> +	ret = driver_set_override(dev, &sch->driver_override, buf, count);
> +	if (ret)
> +		return ret;
>   
>   	return count;
>   }
