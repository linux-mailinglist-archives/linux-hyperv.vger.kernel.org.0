Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F6715AFF
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 May 2023 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjE3KF2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 May 2023 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjE3KF1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 May 2023 06:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5FFE
        for <linux-hyperv@vger.kernel.org>; Tue, 30 May 2023 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685441085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rOfxpMKudv/OZPqUJd3UZe63NtZeJsmKL7503HrnT0=;
        b=DWIrU2K7bP+0UaEbOvykLRxX147JMujQcZOudxPG8cwg69yt0IB3kncdYt+BETgDBydUBh
        BN7mgLNF1W27ji5s/Ug5v1Cbp33QD7rlZ4zPKZNBAb86YAUmy7YAY1UqavHeXbSljxN9px
        vKjzLH5jmFoL1voQcmabKy96d98yyEw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-tPwTOdY3OT-GCCs0XelvHw-1; Tue, 30 May 2023 06:04:43 -0400
X-MC-Unique: tPwTOdY3OT-GCCs0XelvHw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b46e281eso3598261cf.0
        for <linux-hyperv@vger.kernel.org>; Tue, 30 May 2023 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685441083; x=1688033083;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rOfxpMKudv/OZPqUJd3UZe63NtZeJsmKL7503HrnT0=;
        b=W2zrktrmAmfxUNoohimsW71kfa/fxzkPbTffuH3ShNSn9COFuHR4NVp5g55bYdiZpT
         ovKxu+yK52HXnAR1zF6RymCVKxUy0GprSMQ7ZtV7hXMKUvSyaV6BoYblESjL2z8aFjHi
         jzWi3saHlLSu0U02cPhNJtiMYGZdmn9YwAlyai1jc0fOFsIDLi5X1yrKI5IRD088fmeT
         IcMoCabt8gO355ro60U+KTPin+RerxiIhInS41oJgMgdMffJshs1DcrmMhU8Cob2BExW
         oYYyiDYFN0ZiSfv+pKjSuOJjS03nt5rO4p1/MrYfmZT3xy/AzshKkGoJ8gfPGwaVG+xN
         Gd1Q==
X-Gm-Message-State: AC+VfDwXnmogGRHISaz8FxOyArJ308i4i9tfsGRM4kaga3IhjMHlLOIb
        O/7g/yF+xnce26Jx+c59wATEuCqWqEvi6gf9efvFDNdfhhEdCwQ0pgBynnAw9yDg9Xgkt3PNjol
        BoOWyGRZpYeHt4sNMRXUMdSUC
X-Received: by 2002:a05:6214:e4e:b0:625:ba46:27cf with SMTP id o14-20020a0562140e4e00b00625ba4627cfmr1585903qvc.2.1685441083434;
        Tue, 30 May 2023 03:04:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5j41B9i33Ri3qPI7OwceeU9fboi2Hka3a7gfcqLbtL58UfmrI1UFEAQjj5eGkBTrIw2TKIJA==
X-Received: by 2002:a05:6214:e4e:b0:625:ba46:27cf with SMTP id o14-20020a0562140e4e00b00625ba4627cfmr1585888qvc.2.1685441083197;
        Tue, 30 May 2023 03:04:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-248-97.dyn.eolo.it. [146.241.248.97])
        by smtp.gmail.com with ESMTPSA id q20-20020ad44354000000b0062596d5b6a0sm4482088qvs.54.2023.05.30.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:04:42 -0700 (PDT)
Message-ID: <5a432a0c18719adcfe4768e1c541010a8c22ea11.camel@redhat.com>
Subject: Re: [PATCH V3,net] net: mana: Fix perf regression: remove rx_cqes,
 tx_cqes counters
From:   Paolo Abeni <pabeni@redhat.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc:     decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        sharmaajay@microsoft.com, hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Tue, 30 May 2023 12:04:36 +0200
In-Reply-To: <1685115537-31675-1-git-send-email-haiyangz@microsoft.com>
References: <1685115537-31675-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 2023-05-26 at 08:38 -0700, Haiyang Zhang wrote:
> The apc->eth_stats.rx_cqes is one per NIC (vport), and it's on the
> frequent and parallel code path of all queues. So, r/w into this
> single shared variable by many threads on different CPUs creates a
> lot caching and memory overhead, hence perf regression. And, it's
> not accurate due to the high volume concurrent r/w.
>=20
> For example, a workload is iperf with 128 threads, and with RPS
> enabled. We saw perf regression of 25% with the previous patch
> adding the counters. And this patch eliminates the regression.
>=20
> Since the error path of mana_poll_rx_cq() already has warnings, so
> keeping the counter and convert it to a per-queue variable is not
> necessary. So, just remove this counter from this high frequency
> code path.
>=20
> Also, remove the tx_cqes counter for the same reason. We have
> warnings & other counters for errors on that path, and don't need
> to count every normal cqe processing.

FTR, if in future you will need the above counters again, you could re-
add them using per-cpu variables to avoid re-introducing the regression
addressed here.

Cheers,

Paolo

