Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F164152BFA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 May 2022 18:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiERQFb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 May 2022 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbiERQFa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 May 2022 12:05:30 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5F1D675A
        for <linux-hyperv@vger.kernel.org>; Wed, 18 May 2022 09:05:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id c9so1158503qvx.8
        for <linux-hyperv@vger.kernel.org>; Wed, 18 May 2022 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AsDPJQJoORPGh0qS4EUeaOiktBXOii5jyqGHGv+kXII=;
        b=N76w0omWsgq1J3trQP+78nGSW1FVT0gWGjc72Mb7QVydmmWW9+FAv5I3Dcl5COOIKO
         4vA4c/iw6Hjv1lPlLWYuu4ZXAV0cmilaFztjoqQq3rpGsdIFIbi3551Hy18a84tDtlM1
         /PVy20Jd2KeJ0STPnZZTjPBpGkbDWJmfUuaImI4EugibkVhOCmGuKS4x5BqJjjSa84Tw
         nnk40ZmaQIdUG4daGMY+vWEQed0/kZKjkAfoSigwJTPRTsEEfJAYQcPLAAF4LtR/2p+U
         xlREPjULkf2pEVenp75I+mD993ExL5U5UfVfMA2Y0WgBGhVwjcrJdMytRTXhKHsMJl4j
         uWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AsDPJQJoORPGh0qS4EUeaOiktBXOii5jyqGHGv+kXII=;
        b=EcaN+gtdxA6fA3aWR3ZZAUYZGoqSSMXQlPYJ8Ni4seKDJr6lzsMwchjT04boIxPRZ7
         QeVTyRrV1imK7OYCLP04cLKZImiTJd3FZv961xtiUomaLFxTJGmn5OFFYeKmcXTXdem1
         kFU8yZa3xIAdX+bAE3i9YYAVLjKrNFMxvehzY/hlUWgmbJVbAvJq/g6ij5j7mE1JLhx5
         qyeLasvYSi3a1hEFNvqUlve9kCEIxeVOnokPCVSz8ou14rf61xKA3oWe0aZ90538Vy7w
         07lpVjnAclIgdaftyZc1RnciVDziuhZ3FwVY2x4cv79TRUum6/W1jqqJ5i7G+1ntXOyk
         ZUuA==
X-Gm-Message-State: AOAM530j0+4cHhngkDeycSMA0qU7f+S1uOrrkb3VuiWiW3hM9wL04Nnq
        HKNaLVlkWWLyzIDints7eErNmA==
X-Google-Smtp-Source: ABdhPJwuWum5215mzbkNuSWa3OtW1/3pKlaT8sVXotoEFY0mMu9fuRHdN8UiWPfDKaWJgTpYISj/9g==
X-Received: by 2002:a05:6214:224d:b0:461:f264:ba2 with SMTP id c13-20020a056214224d00b00461f2640ba2mr406148qvc.43.1652889927418;
        Wed, 18 May 2022 09:05:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002f39b99f670sm1567656qtk.10.2022.05.18.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 09:05:26 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nrMAv-008VXe-MH; Wed, 18 May 2022 13:05:25 -0300
Date:   Wed, 18 May 2022 13:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ajay Sharma <sharmaajay@microsoft.com>
Cc:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 05/12] net: mana: Set the DMA device max
 page size
Message-ID: <20220518160525.GP63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
 <20220517145949.GH63055@ziepe.ca>
 <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20220517193515.GN63055@ziepe.ca>
 <PH7PR21MB3263C44368F02B8AF8521C4ACECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
 <20220518000356.GO63055@ziepe.ca>
 <BL1PR21MB3283790E8270ED6C639AAB0DD6D19@BL1PR21MB3283.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR21MB3283790E8270ED6C639AAB0DD6D19@BL1PR21MB3283.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 18, 2022 at 05:59:00AM +0000, Ajay Sharma wrote:
> Thanks Long. 
> Hello Jason,
> I am the author of the patch.
> To your comment below : 
> " As I've already said, you are supposed to set the value that limits to ib_sge and *NOT* the value that is related to ib_umem_find_best_pgsz. It is usually 2G because the ib_sge's typically work on a 32 bit length."
> 
> The ib_sge is limited by the __sg_alloc_table_from_pages() which
> uses ib_dma_max_seg_size() which is what is set by the eth driver
> using dma_set_max_seg_size() . Currently our hw does not support
> PTEs larger than 2M.

*sigh* again it has nothing to do with *PTEs* in the HW.

Jason
