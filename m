Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD466B116B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Mar 2023 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCHSxL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Mar 2023 13:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCHSxJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Mar 2023 13:53:09 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41C52F50;
        Wed,  8 Mar 2023 10:53:08 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17638494edbso19705928fac.10;
        Wed, 08 Mar 2023 10:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678301588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gxzy7Shv3K5kndZdg18j/BKNfuePr8ROMkZj5QcE5o=;
        b=7SC717uPYRMBZFFiJvFoOTjDQVLPRQP1Ixf+AYLvjrS5wkEEnsZ/5fBZKudCKtA8lX
         KGx+8S+UQKYCwsGulu9XA/Jkyo6SFNzI+L4yLrGKTr/PKL3U2vP/MU1Z3+C9a1dtTrBX
         8AkU/AVG9ssfEuhvfC0fhxNohVXdRpQpbfuRIq127EEqJ/2HfN3Nw579haKJs4vCe/EB
         dA+barefDgH/mpGaVPptHCxoeJIYnLCLSQMw9y7EF5X5TaykDf604+N26P8f6hgbV6N/
         e/lPwyLbkgOYwOkg2J/i7r89jCg3Hia4BOMgJEq7o6bO6MMz6oBJS6t8FRJPVAIRLlAI
         Y69A==
X-Gm-Message-State: AO0yUKUnFfL5+kYB2rrP8LtCfqc+CZAkihWYryHYAKmh0ZoEOIaDu70l
        rh+7QccyVK2DKTWORPsixQ==
X-Google-Smtp-Source: AK7set8kULLoFE/KOV61S9k/VZ3E+5cWe0/BRd+gU2srW3MP/rSooySFQM58DsK5jZh9oDOBrLQlvw==
X-Received: by 2002:a05:6870:610a:b0:176:4756:d6d5 with SMTP id s10-20020a056870610a00b001764756d6d5mr11695448oae.31.1678301587837;
        Wed, 08 Mar 2023 10:53:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n13-20020a4a954d000000b0052645f842dfsm1782930ooi.44.2023.03.08.10.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 10:53:07 -0800 (PST)
Received: (nullmailer pid 3590795 invoked by uid 1000);
        Wed, 08 Mar 2023 18:53:06 -0000
Date:   Wed, 8 Mar 2023 12:53:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com, decui@microsoft.com,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        linux-acpi@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, haiyangz@microsoft.com, mikelley@microsoft.com,
        lenb@kernel.org
Subject: Re: [PATCH v7 4/5] dt-bindings: bus: VMBus
Message-ID: <167830158609.3590726.11518299594459821573.robh@kernel.org>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-5-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677151745-16521-5-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Thu, 23 Feb 2023 03:29:04 -0800, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V7]
> - update ranges; property in simplie-bus for correct 1:1 translation.
> 
>  .../bindings/bus/microsoft,vmbus.yaml         | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

