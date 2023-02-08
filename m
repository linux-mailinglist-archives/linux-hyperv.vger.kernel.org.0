Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627268ECC2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHK0L (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Feb 2023 05:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjBHK0G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Feb 2023 05:26:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C34670C
        for <linux-hyperv@vger.kernel.org>; Wed,  8 Feb 2023 02:26:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h3so8390333wrp.10
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Feb 2023 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2vBRxdK4AYNAIN8xzgOiscHELLsk42uD/uHH62t4p4=;
        b=vOROfMvBVQUgrGeyXGyUeffueIr97W6RjcIkK+MYIbMJ6JNOyOnqkGZfVGO8gZ6aoz
         9k5Fu8LGDq6RW+AtqbYXNg5+6lqk7fblSpB9wc7XHUkXz1GYroi2LuM9s/a1HxFhHJke
         UrIOQr8QaTC5R1WUi+m3z6P1ioebAlVweRv/MPYQ3Crx7lodeQWX7MQjgJermHKGFjfV
         Bwwdmi5OCYApcfovBDqHj8oR5tHRSe4iMz4xgV9g7EA3YwFvswcpAiBSVZqkZ8dihNG1
         8O2i+V/b1+AG00gmvX/2+vFjy7I3ic5y0X/icVlzGWuCM85kAmziqPJasnvDj8k9uGjb
         1kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2vBRxdK4AYNAIN8xzgOiscHELLsk42uD/uHH62t4p4=;
        b=KPQsz625VISJYTrPE99m/VdCBRaAS+SZO9Wcsju7HXZk5CiWHB2R8M5rCBYDMyDJXR
         f38zThUDNtTAYh9as6qf+iZuqUyFbuRv5GVgeP69cnphMwFXwesIiIPS1ku0f7qC/mZP
         KxIUU2Py2eN6GPcvlnsphvii4LToVaED0EuZ2uelq0HQZuNwQHUa+u9HYnUagBTlaKI7
         Yx0TqI4GNNeJozexhzcROCxw9gcpdBQQA6fzklynoNf7HgwA/eWJcxklrdmUaKjBkT/k
         B7JehThwCGegptq5n+xg1BfXchoiHMYZaRkfV5FZnHyPqQlNupbuJrQ+Jd4DxEYHxtdg
         Nlbw==
X-Gm-Message-State: AO0yUKUVazysiZT/U2nPjFTbq5bRcadhYAjESDLdC3nqqsn/lNUCVBDE
        wIdNxtauFVCqxbgN/mB3OJtADQ==
X-Google-Smtp-Source: AK7set+rGmjIfvS3baxKVbA0bxotZKgIUCw5HvLE3AnsK14SnALoXFJXe76PRDqzgumVmQzFWq+1CA==
X-Received: by 2002:a05:6000:110e:b0:2bf:95fb:e5b3 with SMTP id z14-20020a056000110e00b002bf95fbe5b3mr5948875wrw.33.1675851959784;
        Wed, 08 Feb 2023 02:25:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b002c3b2afae00sm13064383wrq.41.2023.02.08.02.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:25:59 -0800 (PST)
Message-ID: <39350ee9-c899-ba88-2e4e-103f93dcd722@linaro.org>
Date:   Wed, 8 Feb 2023 11:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 6/6] Driver: VMBus: Add device tree support
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <1675756199-5917-7-git-send-email-ssengar@linux.microsoft.com>
 <202302081621.odizDzHG-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <202302081621.odizDzHG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 08/02/2023 09:22, kernel test robot wrote:
> Hi Saurabh,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20230207]
> [cannot apply to robh/for-next tip/timers/core brgl/gpio/for-next wsa/i2c/for-next linus/master v6.2-rc7 v6.2-rc6 v6.2-rc5 v6.2-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 

All of your recent patches have build errors. Can you at least build
test them before sending? It's a unnecessary noise in our mailboxes to
get non-buildable patches, just to trigger compilation which you can
easily do by your own. GCC is a free software...

Best regards,
Krzysztof

