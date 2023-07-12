Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8717D7505B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jul 2023 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGLLOs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jul 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjGLLOr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jul 2023 07:14:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6529E10FC;
        Wed, 12 Jul 2023 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689160485; x=1720696485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pa2Bj6VqT5cElyyhfEvI8AxkZz4IX9juc4rRJw0HbBE=;
  b=hFYg/N22Sh9CfxaftH8T5xpVegf2lB1XDELWh8aWRe23i4sHP1idMeX/
   ZNTeJ8EwlFlVb0jtLfJfoxFbqAQKLwJUl5Z7KAeBWro6MaWe0l7DOmtMu
   9p56+g98xyXcP+yo7vREKzlNHJMO7Bhjrt2YVPh8JjWFrsfvVdtKoYN6j
   jnPHTGE+oCIawcNeF0atihkCmqCA3+cWV9JWs8ADXE9ZnFoOrYgNTjuyM
   rEBakjD4CkOf6TPuMrn2ozKAbgIOqti63kiZ0enkc3WQM8nF/09yrw3wi
   IRn9tDWTTI86UplLNhiwI5rCsankuzs/RZyfRETT2g6G4zkMRDJ3CLpv+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368396155"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="368396155"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1052148842"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="1052148842"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.31.249]) ([10.213.31.249])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 04:13:48 -0700
Message-ID: <60a183df-9776-1f10-bbd7-248531921888@intel.com>
Date:   Wed, 12 Jul 2023 13:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Evan Quan <evan.quan@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        David Francis <David.Francis@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lang Yu <Lang.Yu@amd.com>, Philip Yang <Philip.Yang@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Tim Huang <Tim.Huang@amd.com>, Zack Rusin <zackr@vmware.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Alan Liu <haoping.liu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Aaron Liu <aaron.liu@amd.com>, Melissa Wen <mwen@igalia.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Tadokoro <davidbtadokoro@usp.br>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        Roman Li <roman.li@amd.com>,
        =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= 
        <samsagax@gmail.com>, Dave Airlie <airlied@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@nxp.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Vinod Govindapillai <vinod.govindapillai@intel.com>,
        =?UTF-8?Q?=c5=81ukasz_Bartosik?= <lb@semihalf.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
        Swati Sharma <swati2.sharma@intel.com>,
        =?UTF-8?Q?Jouni_H=c3=b6gander?= <jouni.hogander@intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Arun R Murthy <arun.r.murthy@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Animesh Manna <animesh.manna@intel.com>,
        Deepak R Varma <drv@mailo.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vandita Kulkarni <vandita.kulkarni@intel.com>,
        Suraj Kandpal <suraj.kandpal@intel.com>,
        Drew Davenport <ddavenport@chromium.org>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dan Carpenter <error27@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Marek Vasut <marex@denx.de>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Emma Anholt <emma@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Lechner <david@lechnology.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Michal Simek <michal.simek@amd.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-samsung-soc@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        spice-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, xen-devel@lists.xenproject.org,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-mips@vger.kernel.org,
        Chia-I Wu <olvaffe@gmail.com>,
        linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        John Stultz <jstultz@google.com>,
        freedreno@lists.freedesktop.org,
        Lucas Stach <l.stach@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
 <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
 <acd7913-3c42-7354-434-a826b6c8718@inria.fr>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <acd7913-3c42-7354-434-a826b6c8718@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 12.07.2023 13:07, Julia Lawall wrote:
>
> On Wed, 12 Jul 2023, Uwe Kleine-König wrote:
>
>> On Wed, Jul 12, 2023 at 12:46:33PM +0200, Christian König wrote:
>>> Am 12.07.23 um 11:46 schrieb Uwe Kleine-König:
>>>> Hello,
>>>>
>>>> while I debugged an issue in the imx-lcdc driver I was constantly
>>>> irritated about struct drm_device pointer variables being named "dev"
>>>> because with that name I usually expect a struct device pointer.
>>>>
>>>> I think there is a big benefit when these are all renamed to "drm_dev".
>>>> I have no strong preference here though, so "drmdev" or "drm" are fine
>>>> for me, too. Let the bikesheding begin!
>>>>
>>>> Some statistics:
>>>>
>>>> $ git grep -ohE 'struct drm_device *\* *[^ (),;]*' v6.5-rc1 | sort | uniq -c | sort -n
>>>>         1 struct drm_device *adev_to_drm
>>>>         1 struct drm_device *drm_
>>>>         1 struct drm_device          *drm_dev
>>>>         1 struct drm_device        *drm_dev
>>>>         1 struct drm_device *pdev
>>>>         1 struct drm_device *rdev
>>>>         1 struct drm_device *vdev
>>>>         2 struct drm_device *dcss_drv_dev_to_drm
>>>>         2 struct drm_device **ddev
>>>>         2 struct drm_device *drm_dev_alloc
>>>>         2 struct drm_device *mock
>>>>         2 struct drm_device *p_ddev
>>>>         5 struct drm_device *device
>>>>         9 struct drm_device * dev
>>>>        25 struct drm_device *d
>>>>        95 struct drm_device *
>>>>       216 struct drm_device *ddev
>>>>       234 struct drm_device *drm_dev
>>>>       611 struct drm_device *drm
>>>>      4190 struct drm_device *dev
>>>>
>>>> This series starts with renaming struct drm_crtc::dev to drm_dev. If
>>>> it's not only me and others like the result of this effort it should be
>>>> followed up by adapting the other structs and the individual usages in
>>>> the different drivers.
>>>>
>>>> To make this series a bit easier handleable, I first added an alias for
>>>> drm_crtc::dev, then converted the drivers one after another and the last
>>>> patch drops the "dev" name. This has the advantage of being easier to
>>>> review, and if I should have missed an instance only the last patch must
>>>> be dropped/reverted. Also this series might conflict with other patches,
>>>> in this case the remaining patches can still go in (apart from the last
>>>> one of course). Maybe it also makes sense to delay applying the last
>>>> patch by one development cycle?
>>> When you automatically generate the patch (with cocci for example) I usually
>>> prefer a single patch instead.
>> Maybe I'm too stupid, but only parts of this patch were created by
>> coccinelle. I failed to convert code like
>>
>> -       spin_lock_irq(&crtc->dev->event_lock);
>> +       spin_lock_irq(&crtc->drm_dev->event_lock);
>>
>> Added Julia to Cc, maybe she has a hint?!
> A priori, I see no reason why the rule below should not apply to the above
> code.  Is there a parsing problem in the containing function?  You can run
>
> spatch --parse-c file.c
>
> If there is a paring problem, please let me know and i will try to fix it
> so the while thing can be done automatically.

I guess some clever macros can fool spatch, at least I observe such 
things in i915 which often uses custom iterators.

Regards
Andrzej

>
> julia
>
>> (Up to now it's only
>>
>> @@
>> struct drm_crtc *crtc;
>> @@
>> -crtc->dev
>> +crtc->drm_dev
>>
>> )
>>
>>> Background is that this makes merge conflicts easier to handle and detect.
>> Really? Each file (apart from include/drm/drm_crtc.h) is only touched
>> once. So unless I'm missing something you don't get less or easier
>> conflicts by doing it all in a single patch. But you gain the freedom to
>> drop a patch for one driver without having to drop the rest with it. So
>> I still like the split version better, but I'm open to a more verbose
>> reasoning from your side.
>>
>>> When you have multiple patches and a merge conflict because of some added
>>> lines using the old field the build breaks only on the last patch which
>>> removes the old field.
>> Then you can revert/drop the last patch without having to respin the
>> whole single patch and thus caring for still more conflicts that arise
>> until the new version is sent.
>>
>> Best regards
>> Uwe
>>
>> --
>> Pengutronix e.K.                           | Uwe Kleine-König            |
>> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
> >

